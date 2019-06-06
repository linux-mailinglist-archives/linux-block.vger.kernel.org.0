Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87F373A9
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2019 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfFFL6x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jun 2019 07:58:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfFFL6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 07:58:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so1386463pfc.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jun 2019 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzwoRC5gKL8eyZgW+isHhbR7yP8S9NSbd80KIYWUksk=;
        b=Xew1BIY/zwHvtBhI/AS7uwq3eEBwUBTNM5AcyI9aIEnXlFaog8EEDT9P1ugw6jcLeA
         KDYYQ+tYMKmvCgQNCDXs5Qr57MtfMyEc2P0iCbPUMceQ63KWscUHcJpxujKbzjR573H/
         e8ABuycSoTPnp9ZaWT9PCCKJ4D4K7cGKSlldY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzwoRC5gKL8eyZgW+isHhbR7yP8S9NSbd80KIYWUksk=;
        b=McCCjPISFp+WRccjKTwHAXsATISb5P8XwaXEEwPN6y/t1NCceATi7wnVcRtjBWq0G4
         Aq9XGnLPd2LDFqShl32Hy/3vSmv/r1Of8uc/ad2rAp7TYrS1Q00VWM7KhEu63PRr+2HC
         LATq2UxotpcLh0cm4V68DfCdaSnr328LCBk1vVqK86JboTnL5+YAUIvTnx2tu71rhgsr
         MHH4HIYkC4GoAVCK+UMidt2G+hr2bkuC5u3ygDndm/rF2H0uA4d31DcFkiElqlERAg4x
         7lukSM3NCK5Kg7riMZ2NYIGF5auHdX1IHfvjTEi8akuXVj+vSZX/q7lCrowq7HKhAu01
         mG3Q==
X-Gm-Message-State: APjAAAVHeg54a78ZbBq7Jn4zYQW9gVHRy2RIMeq/wVBoyeoRwqk4N0yq
        2ULomgIxngYnJfPfTqbSR9+fswlNSNVujtmP/a/QmvfRa10=
X-Google-Smtp-Source: APXvYqxyxTySzwpqu0BE7tSY6/2rF2e6OzwGQw7VBTPFLzDs6mi0jWo18FbEmYZuIFTwiHAWVDGFvp1zvf2FXAa1BmI=
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr50069724pjs.93.1559822331728;
 Thu, 06 Jun 2019 04:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-10-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-10-ming.lei@redhat.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Thu, 6 Jun 2019 17:28:40 +0530
Message-ID: <CAK=zhgqY0ZTbg1wyHDr9EPn=G63upo+Do-Sm5L-AJrsCkJTynQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] scsi: mp3sas: convert private reply queue to blk-mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming - We have one outstanding series posted for mpt3sas driver. Your next
revision may need rebase considering below update -

https://marc.info/?l=linux-scsi&m=155930490520681&w=2

Thanks & Regards,
Sreekanth

On Fri, May 31, 2019 at 7:59 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> SCSI's reply qeueue is very similar with blk-mq's hw queue, both
> assigned by IRQ vector, so map te private reply queue into blk-mq's hw
> queue via .host_tagset.
>
> Then the private reply mapping can be removed.
>
> Another benefit is that the request/irq lost issue may be solved in
> generic approach because managed IRQ may be shutdown during CPU
> hotplug.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c  | 74 +++++-----------------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h  |  3 +-
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 17 +++++++
>  3 files changed, 31 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 8aacbd1e7db2..2b207d2925b4 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -2855,8 +2855,7 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
>  static void
>  _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
>  {
> -       unsigned int cpu, nr_cpus, nr_msix, index = 0;
> -       struct adapter_reply_queue *reply_q;
> +       unsigned int nr_cpus, nr_msix;
>
>         if (!_base_is_controller_msix_enabled(ioc))
>                 return;
> @@ -2866,50 +2865,9 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
>                 return;
>         }
>
> -       memset(ioc->cpu_msix_table, 0, ioc->cpu_msix_table_sz);
> -
>         nr_cpus = num_online_cpus();
>         nr_msix = ioc->reply_queue_count = min(ioc->reply_queue_count,
>                                                ioc->facts.MaxMSIxVectors);
> -       if (!nr_msix)
> -               return;
> -
> -       if (smp_affinity_enable) {
> -               list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
> -                       const cpumask_t *mask = pci_irq_get_affinity(ioc->pdev,
> -                                                       reply_q->msix_index);
> -                       if (!mask) {
> -                               ioc_warn(ioc, "no affinity for msi %x\n",
> -                                        reply_q->msix_index);
> -                               continue;
> -                       }
> -
> -                       for_each_cpu_and(cpu, mask, cpu_online_mask) {
> -                               if (cpu >= ioc->cpu_msix_table_sz)
> -                                       break;
> -                               ioc->cpu_msix_table[cpu] = reply_q->msix_index;
> -                       }
> -               }
> -               return;
> -       }
> -       cpu = cpumask_first(cpu_online_mask);
> -
> -       list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
> -
> -               unsigned int i, group = nr_cpus / nr_msix;
> -
> -               if (cpu >= nr_cpus)
> -                       break;
> -
> -               if (index < nr_cpus % nr_msix)
> -                       group++;
> -
> -               for (i = 0 ; i < group ; i++) {
> -                       ioc->cpu_msix_table[cpu] = reply_q->msix_index;
> -                       cpu = cpumask_next(cpu, cpu_online_mask);
> -               }
> -               index++;
> -       }
>  }
>
>  /**
> @@ -2924,6 +2882,7 @@ _base_disable_msix(struct MPT3SAS_ADAPTER *ioc)
>                 return;
>         pci_disable_msix(ioc->pdev);
>         ioc->msix_enable = 0;
> +       ioc->smp_affinity_enable = 0;
>  }
>
>  /**
> @@ -2980,6 +2939,9 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
>                 goto try_ioapic;
>         }
>
> +       if (irq_flags & PCI_IRQ_AFFINITY)
> +               ioc->smp_affinity_enable = 1;
> +
>         ioc->msix_enable = 1;
>         ioc->reply_queue_count = r;
>         for (i = 0; i < ioc->reply_queue_count; i++) {
> @@ -3266,7 +3228,7 @@ mpt3sas_base_get_reply_virt_addr(struct MPT3SAS_ADAPTER *ioc, u32 phys_addr)
>  }
>
>  static inline u8
> -_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
> +_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd)
>  {
>         /* Enables reply_queue load balancing */
>         if (ioc->msix_load_balance)
> @@ -3274,7 +3236,7 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
>                     base_mod64(atomic64_add_return(1,
>                     &ioc->total_io_cnt), ioc->reply_queue_count) : 0;
>
> -       return ioc->cpu_msix_table[raw_smp_processor_id()];
> +       return scsi_cmnd_hctx_index(ioc->shost, scmd);
>  }
>
>  /**
> @@ -3325,7 +3287,7 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
>
>         smid = tag + 1;
>         request->cb_idx = cb_idx;
> -       request->msix_io = _base_get_msix_index(ioc);
> +       request->msix_io = _base_get_msix_index(ioc, scmd);
>         request->smid = smid;
>         INIT_LIST_HEAD(&request->chain_list);
>         return smid;
> @@ -3498,7 +3460,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
>         _base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
>                                         ioc->request_sz);
>         descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
> -       descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
> +       descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
>         descriptor.SCSIIO.SMID = cpu_to_le16(smid);
>         descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
>         descriptor.SCSIIO.LMID = 0;
> @@ -3520,7 +3482,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
>
>
>         descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
> -       descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
> +       descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
>         descriptor.SCSIIO.SMID = cpu_to_le16(smid);
>         descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
>         descriptor.SCSIIO.LMID = 0;
> @@ -3543,7 +3505,7 @@ mpt3sas_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
>
>         descriptor.SCSIIO.RequestFlags =
>             MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
> -       descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc);
> +       descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
>         descriptor.SCSIIO.SMID = cpu_to_le16(smid);
>         descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
>         descriptor.SCSIIO.LMID = 0;
> @@ -3607,7 +3569,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
>
>         descriptor.Default.RequestFlags =
>                 MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
> -       descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
> +       descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
>         descriptor.Default.SMID = cpu_to_le16(smid);
>         descriptor.Default.LMID = 0;
>         descriptor.Default.DescriptorTypeDependent = 0;
> @@ -3639,7 +3601,7 @@ mpt3sas_base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
>         }
>         request = (u64 *)&descriptor;
>         descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
> -       descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
> +       descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
>         descriptor.Default.SMID = cpu_to_le16(smid);
>         descriptor.Default.LMID = 0;
>         descriptor.Default.DescriptorTypeDependent = 0;
> @@ -6524,19 +6486,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
>
>         dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
>
> -       /* setup cpu_msix_table */
>         ioc->cpu_count = num_online_cpus();
>         for_each_online_cpu(cpu_id)
>                 last_cpu_id = cpu_id;
>         ioc->cpu_msix_table_sz = last_cpu_id + 1;
> -       ioc->cpu_msix_table = kzalloc(ioc->cpu_msix_table_sz, GFP_KERNEL);
>         ioc->reply_queue_count = 1;
> -       if (!ioc->cpu_msix_table) {
> -               dfailprintk(ioc,
> -                           ioc_info(ioc, "allocation for cpu_msix_table failed!!!\n"));
> -               r = -ENOMEM;
> -               goto out_free_resources;
> -       }
>
>         if (ioc->is_warpdrive) {
>                 ioc->reply_post_host_index = kcalloc(ioc->cpu_msix_table_sz,
> @@ -6748,7 +6702,6 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
>         mpt3sas_base_free_resources(ioc);
>         _base_release_memory_pools(ioc);
>         pci_set_drvdata(ioc->pdev, NULL);
> -       kfree(ioc->cpu_msix_table);
>         if (ioc->is_warpdrive)
>                 kfree(ioc->reply_post_host_index);
>         kfree(ioc->pd_handles);
> @@ -6789,7 +6742,6 @@ mpt3sas_base_detach(struct MPT3SAS_ADAPTER *ioc)
>         _base_release_memory_pools(ioc);
>         mpt3sas_free_enclosure_list(ioc);
>         pci_set_drvdata(ioc->pdev, NULL);
> -       kfree(ioc->cpu_msix_table);
>         if (ioc->is_warpdrive)
>                 kfree(ioc->reply_post_host_index);
>         kfree(ioc->pd_handles);
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
> index 480219f0efc5..4d441e031025 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@ -1022,7 +1022,6 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
>   * @start_scan_failed: means port enable failed, return's the ioc_status
>   * @msix_enable: flag indicating msix is enabled
>   * @msix_vector_count: number msix vectors
> - * @cpu_msix_table: table for mapping cpus to msix index
>   * @cpu_msix_table_sz: table size
>   * @total_io_cnt: Gives total IO count, used to load balance the interrupts
>   * @msix_load_balance: Enables load balancing of interrupts across
> @@ -1183,6 +1182,7 @@ struct MPT3SAS_ADAPTER {
>         u16             broadcast_aen_pending;
>         u8              shost_recovery;
>         u8              got_task_abort_from_ioctl;
> +       u8              smp_affinity_enable;
>
>         struct mutex    reset_in_progress_mutex;
>         spinlock_t      ioc_reset_in_progress_lock;
> @@ -1199,7 +1199,6 @@ struct MPT3SAS_ADAPTER {
>
>         u8              msix_enable;
>         u16             msix_vector_count;
> -       u8              *cpu_msix_table;
>         u16             cpu_msix_table_sz;
>         resource_size_t __iomem **reply_post_host_index;
>         u32             ioc_reset_count;
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 1ccfbc7eebe0..59c1f9e694a0 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -55,6 +55,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/aer.h>
>  #include <linux/raid_class.h>
> +#include <linux/blk-mq-pci.h>
>  #include <asm/unaligned.h>
>
>  #include "mpt3sas_base.h"
> @@ -10161,6 +10162,17 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
>         return 1;
>  }
>
> +static int mpt3sas_map_queues(struct Scsi_Host *shost)
> +{
> +       struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
> +       struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> +
> +       if (ioc->smp_affinity_enable)
> +               return blk_mq_pci_map_queues(qmap, ioc->pdev, 0);
> +       else
> +               return blk_mq_map_queues(qmap);
> +}
> +
>  /* shost template for SAS 2.0 HBA devices */
>  static struct scsi_host_template mpt2sas_driver_template = {
>         .module                         = THIS_MODULE,
> @@ -10189,6 +10201,8 @@ static struct scsi_host_template mpt2sas_driver_template = {
>         .sdev_attrs                     = mpt3sas_dev_attrs,
>         .track_queue_depth              = 1,
>         .cmd_size                       = sizeof(struct scsiio_tracker),
> +       .host_tagset                    = 1,
> +       .map_queues                     = mpt3sas_map_queues,
>  };
>
>  /* raid transport support for SAS 2.0 HBA devices */
> @@ -10227,6 +10241,8 @@ static struct scsi_host_template mpt3sas_driver_template = {
>         .sdev_attrs                     = mpt3sas_dev_attrs,
>         .track_queue_depth              = 1,
>         .cmd_size                       = sizeof(struct scsiio_tracker),
> +       .host_tagset                    = 1,
> +       .map_queues                     = mpt3sas_map_queues,
>  };
>
>  /* raid transport support for SAS 3.0 HBA devices */
> @@ -10538,6 +10554,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         } else
>                 ioc->hide_drives = 0;
>
> +       shost->nr_hw_queues = ioc->reply_queue_count;
>         rv = scsi_add_host(shost, &pdev->dev);
>         if (rv) {
>                 ioc_err(ioc, "failure at %s:%d/%s()!\n",
> --
> 2.20.1
>
