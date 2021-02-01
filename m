Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA17C30AA74
	for <lists+linux-block@lfdr.de>; Mon,  1 Feb 2021 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBAPHt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Feb 2021 10:07:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBAPG5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Feb 2021 10:06:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7F75AB92;
        Mon,  1 Feb 2021 15:06:51 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] megaraid_sas: iouring iopoll support
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     sumit.saxena@broadcom.com, chandrakanth.patil@broadcom.com,
        linux-block@vger.kernel.org
References: <20210201051619.19909-1-kashyap.desai@broadcom.com>
 <20210201051619.19909-3-kashyap.desai@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <698414dc-401c-10ea-30a9-0aeedc9b1349@suse.de>
Date:   Mon, 1 Feb 2021 16:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201051619.19909-3-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/21 6:16 AM, Kashyap Desai wrote:
> Add support of iouring iopoll interface. This feature requires shared
> hosttag support in kernel and driver.
> 
> Driver will work in non-IRQ mode = There will not be any msix vector
> associated for poll_queues and h/w can still work in this mode.
> MegaRaid h/w is single submission queue and multiple reply queue, but
> using shared host tagset support it will enable simulated multiple hw queue.
> 
> Driver allocates some extra reply queues and it will be marked as poll_queue.
> These poll_queues will not have associated msix vectors. All the IO
> completion on this queue will be done from IOPOLL interface.
> 
> megaraid_sas driver having 8 poll_queues and using io_uring hiprio=1 settings,
> It can reach 3.2M IOPs and there is zero interrupt generated by h/w.
> 
> This feature can be enabled using module parameter poll_queues.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: sumit.saxena@broadcom.com
> Cc: chandrakanth.patil@broadcom.com
> Cc: linux-block@vger.kernel.org
> ---
>   drivers/scsi/megaraid/megaraid_sas.h        |  3 +
>   drivers/scsi/megaraid/megaraid_sas_base.c   | 87 ++++++++++++++++++---
>   drivers/scsi/megaraid/megaraid_sas_fusion.c | 42 +++++++++-
>   drivers/scsi/megaraid/megaraid_sas_fusion.h |  2 +
>   4 files changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
> index 0f808d63580e..d8b1797e2768 100644
> --- a/drivers/scsi/megaraid/megaraid_sas.h
> +++ b/drivers/scsi/megaraid/megaraid_sas.h
> @@ -2212,6 +2212,7 @@ struct megasas_irq_context {
>   	struct irq_poll irqpoll;
>   	bool irq_poll_scheduled;
>   	bool irq_line_enable;
> +	atomic_t   in_used;
>   };
>   
>   struct MR_DRV_SYSTEM_INFO {
> @@ -2446,6 +2447,7 @@ struct megasas_instance {
>   	bool support_pci_lane_margining;
>   	u8  low_latency_index_start;
>   	int perf_mode;
> +	int iopoll_q_count;
>   };
>   
>   struct MR_LD_VF_MAP {
> @@ -2726,5 +2728,6 @@ void megasas_init_debugfs(void);
>   void megasas_exit_debugfs(void);
>   void megasas_setup_debugfs(struct megasas_instance *instance);
>   void megasas_destroy_debugfs(struct megasas_instance *instance);
> +int megasas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num);
>   
>   #endif				/*LSI_MEGARAID_SAS_H */
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 63a4f48bdc75..25673d0ee524 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -114,6 +114,15 @@ unsigned int enable_sdev_max_qd;
>   module_param(enable_sdev_max_qd, int, 0444);
>   MODULE_PARM_DESC(enable_sdev_max_qd, "Enable sdev max qd as can_queue. Default: 0");
>   
> +int poll_queues;
> +module_param(poll_queues, int, 0444);
> +MODULE_PARM_DESC(poll_queues, "Number of queues to be use for io_uring poll mode.\n\t\t"
> +		"This parameter is effective only if host_tagset_enable=1 &\n\t\t"
> +		"It is not applicable for MFI_SERIES. &\n\t\t"
> +		"Driver will work in latency mode. &\n\t\t"
> +		"High iops queues are not allocated &\n\t\t"
> +		);
> +
>   int host_tagset_enable = 1;
>   module_param(host_tagset_enable, int, 0444);
>   MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: enable(1)");
> @@ -207,6 +216,7 @@ static bool support_pci_lane_margining;
>   static spinlock_t poll_aen_lock;
>   
>   extern struct dentry *megasas_debugfs_root;
> +extern int megasas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num);
>   
>   void
>   megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
> @@ -3127,14 +3137,37 @@ megasas_bios_param(struct scsi_device *sdev, struct block_device *bdev,
>   static int megasas_map_queues(struct Scsi_Host *shost)
>   {
>   	struct megasas_instance *instance;
> +	int qoff = 0, offset;
> +	struct blk_mq_queue_map *map;
>   
>   	instance = (struct megasas_instance *)shost->hostdata;
>   
>   	if (shost->nr_hw_queues == 1)
>   		return 0;
>   
> -	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
> -			instance->pdev, instance->low_latency_index_start);
> +	offset = instance->low_latency_index_start;
> +
> +	/* Setup Default hctx */
> +	map = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> +	map->nr_queues = instance->msix_vectors - offset;
> +	map->queue_offset = 0;
> +	blk_mq_pci_map_queues(map, instance->pdev, offset);
> +	qoff += map->nr_queues;
> +	offset += map->nr_queues;
> +
> +	/* Setup Poll hctx */
> +	map = &shost->tag_set.map[HCTX_TYPE_POLL];
> +	map->nr_queues = instance->iopoll_q_count;
> +	if (map->nr_queues) {
> +		/*
> +		 * The poll queue(s) doesn't have an IRQ (and hence IRQ
> +		 * affinity), so use the regular blk-mq cpu mapping
> +		 */
> +		map->queue_offset = qoff;
> +		blk_mq_map_queues(map);
> +	}
> +
> +	return 0;
>   }
>   
>   static void megasas_aen_polling(struct work_struct *work);
> @@ -3446,6 +3479,7 @@ static struct scsi_host_template megasas_template = {
>   	.shost_attrs = megaraid_host_attrs,
>   	.bios_param = megasas_bios_param,
>   	.map_queues = megasas_map_queues,
> +	.mq_poll = megasas_blk_mq_poll,
>   	.change_queue_depth = scsi_change_queue_depth,
>   	.max_segment_size = 0xffffffff,
>   };
> @@ -5834,13 +5868,16 @@ __megasas_alloc_irq_vectors(struct megasas_instance *instance)
>   	irq_flags = PCI_IRQ_MSIX;
>   
>   	if (instance->smp_affinity_enable)
> -		irq_flags |= PCI_IRQ_AFFINITY;
> +		irq_flags |= PCI_IRQ_AFFINITY | PCI_IRQ_ALL_TYPES;
>   	else
>   		descp = NULL;
>   
> +	/* Do not allocate msix vectors for poll_queues.
> +	 * msix_vectors is always within a range of FW supported reply queue.
> +	 */
>   	i = pci_alloc_irq_vectors_affinity(instance->pdev,
>   		instance->low_latency_index_start,
> -		instance->msix_vectors, irq_flags, descp);
> +		instance->msix_vectors - instance->iopoll_q_count, irq_flags, descp);
>   
>   	return i;
>   }
> @@ -5856,10 +5893,30 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
>   	int i;
>   	unsigned int num_msix_req;
>   
> +	instance->iopoll_q_count = 0;
> +	if ((instance->adapter_type != MFI_SERIES) &&
> +		poll_queues) {
> +
> +		instance->perf_mode = MR_LATENCY_PERF_MODE;
> +		instance->low_latency_index_start = 1;
> +
> +		/* reserve for default and non-mananged pre-vector. */
> +		if (instance->msix_vectors > (poll_queues + 2))
> +			instance->iopoll_q_count = poll_queues;
> +		else
> +			instance->iopoll_q_count = 0;
> +
> +		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
> +		instance->msix_vectors = min(num_msix_req,
> +				instance->msix_vectors);
> +
> +	}
> +
>   	i = __megasas_alloc_irq_vectors(instance);
>   
> -	if ((instance->perf_mode == MR_BALANCED_PERF_MODE) &&
> -	    (i != instance->msix_vectors)) {
> +	if (((instance->perf_mode == MR_BALANCED_PERF_MODE)
> +		|| instance->iopoll_q_count) &&
> +	    (i != (instance->msix_vectors - instance->iopoll_q_count))) {
>   		if (instance->msix_vectors)
>   			pci_free_irq_vectors(instance->pdev);
>   		/* Disable Balanced IOPS mode and try realloc vectors */
> @@ -5870,12 +5927,15 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
>   		instance->msix_vectors = min(num_msix_req,
>   				instance->msix_vectors);
>   
> +		instance->iopoll_q_count = 0;
>   		i = __megasas_alloc_irq_vectors(instance);
>   
>   	}
>   
>   	dev_info(&instance->pdev->dev,
> -		"requested/available msix %d/%d\n", instance->msix_vectors, i);
> +		"requested/available msix %d/%d poll_queue %d\n",
> +			instance->msix_vectors - instance->iopoll_q_count,
> +			i, instance->iopoll_q_count);
>   
>   	if (i > 0)
>   		instance->msix_vectors = i;
> @@ -6841,12 +6901,18 @@ static int megasas_io_attach(struct megasas_instance *instance)
>   		instance->smp_affinity_enable) {
>   		host->host_tagset = 1;
>   		host->nr_hw_queues = instance->msix_vectors -
> -			instance->low_latency_index_start;
> +			instance->low_latency_index_start + instance->iopoll_q_count;
> +		if (instance->iopoll_q_count)
> +			host->nr_maps = 3;
> +	} else {
> +		instance->iopoll_q_count = 0;
>   	}
>   
>   	dev_info(&instance->pdev->dev,
> -		"Max firmware commands: %d shared with nr_hw_queues = %d\n",
> -		instance->max_fw_cmds, host->nr_hw_queues);
> +		"Max firmware commands: %d shared with default "
> +		"hw_queues = %d poll_queues %d\n", instance->max_fw_cmds,
> +		host->nr_hw_queues - instance->iopoll_q_count,
> +		instance->iopoll_q_count);
>   	/*
>   	 * Notify the mid-layer about the new controller
>   	 */
> @@ -8859,6 +8925,7 @@ static int __init megasas_init(void)
>   		msix_vectors = 1;
>   		rdpq_enable = 0;
>   		dual_qdepth_disable = 1;
> +		poll_queues = 0;
>   	}
>   
>   	/*
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 38fc9467c625..10b8157044bb 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -685,6 +685,8 @@ megasas_alloc_reply_fusion(struct megasas_instance *instance)
>   	fusion = instance->ctrl_context;
>   
>   	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
> +	count += instance->iopoll_q_count;
> +
>   	fusion->reply_frames_desc_pool =
>   			dma_pool_create("mr_reply", &instance->pdev->dev,
>   				fusion->reply_alloc_sz * count, 16, 0);
> @@ -779,6 +781,7 @@ megasas_alloc_rdpq_fusion(struct megasas_instance *instance)
>   	}
>   
>   	msix_count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
> +	msix_count += instance->iopoll_q_count;
>   
>   	fusion->reply_frames_desc_pool = dma_pool_create("mr_rdpq",
>   							 &instance->pdev->dev,
> @@ -1129,7 +1132,7 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
>   			MPI2_IOCINIT_MSGFLAG_RDPQ_ARRAY_MODE : 0;
>   	IOCInitMessage->SystemRequestFrameBaseAddress = cpu_to_le64(fusion->io_request_frames_phys);
>   	IOCInitMessage->SenseBufferAddressHigh = cpu_to_le32(upper_32_bits(fusion->sense_phys_addr));
> -	IOCInitMessage->HostMSIxVectors = instance->msix_vectors;
> +	IOCInitMessage->HostMSIxVectors = instance->msix_vectors + instance->iopoll_q_count;
>   	IOCInitMessage->HostPageSize = MR_DEFAULT_NVME_PAGE_SHIFT;
>   
>   	time = ktime_get_real();
> @@ -1823,6 +1826,8 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
>   		 sizeof(union MPI2_SGE_IO_UNION))/16;
>   
>   	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
> +	count += instance->iopoll_q_count;
> +
>   	for (i = 0 ; i < count; i++)
>   		fusion->last_reply_idx[i] = 0;
>   
> @@ -1835,6 +1840,9 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
>   				MEGASAS_FUSION_IOCTL_CMDS);
>   	sema_init(&instance->ioctl_sem, MEGASAS_FUSION_IOCTL_CMDS);
>   
> +	for (i = 0; i < MAX_MSIX_QUEUES_FUSION; i++)
> +		atomic_set(&fusion->busy_mq_poll[i], 0);
> +
>   	if (megasas_alloc_ioc_init_frame(instance))
>   		return 1;
>   
> @@ -3500,6 +3508,9 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
>   	if (reply_descript_type == MPI2_RPY_DESCRIPT_FLAGS_UNUSED)
>   		return IRQ_NONE;
>   
> +	if (irq_context && !atomic_add_unless(&irq_context->in_used, 1, 1))
> +		return 0;
> +
>   	num_completed = 0;
>   
>   	while (d_val.u.low != cpu_to_le32(UINT_MAX) &&
> @@ -3613,6 +3624,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
>   					irq_context->irq_line_enable = true;
>   					irq_poll_sched(&irq_context->irqpoll);
>   				}
> +				atomic_dec(&irq_context->in_used);
>   				return num_completed;
>   			}
>   		}
> @@ -3630,9 +3642,35 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
>   				instance->reply_post_host_index_addr[0]);
>   		megasas_check_and_restore_queue_depth(instance);
>   	}
> +
> +	if (irq_context)
> +		atomic_dec(&irq_context->in_used);
> +
>   	return num_completed;
>   }
>   
> +int megasas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
> +{
> +
> +	struct megasas_instance *instance;
> +	int num_entries = 0;
> +	struct fusion_context *fusion;
> +
> +	instance = (struct megasas_instance *)shost->hostdata;
> +
> +	fusion = instance->ctrl_context;
> +
> +	queue_num = queue_num + instance->low_latency_index_start;
> +
> +	if (!atomic_add_unless(&fusion->busy_mq_poll[queue_num], 1, 1))
> +		return 0;
> +
> +	num_entries = complete_cmd_fusion(instance, queue_num, NULL);
> +	atomic_dec(&fusion->busy_mq_poll[queue_num]);
> +
> +	return num_entries;
> +}
> +
>   /**
>    * megasas_enable_irq_poll() - enable irqpoll
>    * @instance:			Adapter soft state

I really wonder if we need the atomic counter here.
complete_cmd_fusion() will already return the number of completed 
commands, so the only benefit we're getting is to avoid calling 
complete_cmd_fusion() if no commands are pending.
But if no commands are pending we are necessarily off the hot path 
anyway, so calling complete_cmd_fusion() here (and have it return 0) 
should matter much.
Am I wrong?

Otherwise: All thumbs up for this work. Very good job.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
