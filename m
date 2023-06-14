Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA77235AA
	for <lists+linux-block@lfdr.de>; Tue,  6 Jun 2023 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjFFDRc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Jun 2023 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjFFDRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 23:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691611B
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686021404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=q0RfyB+wRaMVmrfPDcEL7PT0iuGuLLwJieOrWccLQLM=;
        b=DqlEgWTziBw8g9ZoIiSRRQStWQ3t7RXUhqPWhd2Q6rX8JhQc+7m8rSPV5AaK0IuJZ0Xikv
        CBnFiM8Jvq9daUk2mqD2tBGodmBTswiiY8MPX11y065HltHgL0dqMegjNouwXRrL5sjJXq
        GfdV8TZQsmz/yyPPFAmIU2QFlIst00c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-04auykE9NLyo8tZK0WzXEQ-1; Mon, 05 Jun 2023 23:16:43 -0400
X-MC-Unique: 04auykE9NLyo8tZK0WzXEQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5128dcbdfc1so3394560a12.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 20:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686021402; x=1688613402;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0RfyB+wRaMVmrfPDcEL7PT0iuGuLLwJieOrWccLQLM=;
        b=PqNyMbv+p6hlWuQCllm2v90d5TlVOcr3/kBcmBtWr1X+WXCKHR/jhRVkNb+KVTAM6f
         YGgthzd7W1bFwTgwSFNcUmsW8r5tK2QlWZkp6SnD0feWDkjTAyeBkmHMJ/5GPywGr62T
         +glSGyIiXMInU6vWaOgDDUYsl+nsqrCvgpGEj44qKdERCYS5wEN3zl3KyvqWBfOZMIV+
         oYfKD9/xKkat8igye+y4U9pJof3qKyBzNqPyxLfUTPtCdyLk7Rk+e5PiJcVLqcjJl4ib
         fVALuL6fWHDAayNkyDaBPNzL0IpHmtpgzwqeSf4gBjOFgBBC+/5yoP/S1Gcjiv5dMV8P
         SXEg==
X-Gm-Message-State: AC+VfDzyNA75d7eNVcVCvgditpsPhDE2DTpth7k/b2Lk7sgnkhmowG8V
        WtT3hdhpTBT6w9SID2eFDXF3dUCOUbBTZ04R1BeVGfRSns7nZGu4yGVgQI8b0AB7mA+3DsTZuq5
        fyWNwYuGqJcIQ9IM+FKxUPLHZNr1Ac75TIafznPaH5EBInhKelPcL
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr722351edu.0.1686021402201;
        Mon, 05 Jun 2023 20:16:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49ClK6v/MPZZe0RrYXrXTEPlGTRu6WG4TG9CSzTJco6j3U5HVw5N2YpRVvwayoK9AhU+2cAvois/dl22431JQ=
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id
 s7-20020a056402014700b005149c05819emr722343edu.0.1686021401877; Mon, 05 Jun
 2023 20:16:41 -0700 (PDT)
MIME-Version: 1.0
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Tue, 6 Jun 2023 11:17:47 +0800
Message-ID: <CAGS2=YoMsjT19mVP9Te_Mx1yKpgLDbZuDQnUV_VLCjhJ=F8D8w@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 23 PID: 35995 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        John Meneghini <jmeneghi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
qedf IO testing found the error with latest linux-block/for-next,
please have a look.

kernel repo : https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
commit: Merge branch 'for-6.5/block' into for-next


[ 7305.031233] ------------[ cut here ]------------
[ 7305.033749] [0000:04:00.2]:[qedf_process_error_detect:1525]:11:
tx_buff_off=00000000, rx_buff_off=00000000, rx_id=073f
[ 7305.038904] refcount_t: underflow; use-after-free.
[ 7305.038918] WARNING: CPU: 23 PID: 35995 at lib/refcount.c:28
refcount_warn_saturate+0xba/0x110
[ 7305.065853] Modules linked in: nfsv3 nfs_acl bnx2fc cnic uio
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
netfs sunrpc vfat fat dm_service_time dm_multipath intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm mgag200 i2c_algo_bit drm_shmem_helper
dell_wmi_descriptor drm_kms_helper ipmi_ssif ledtrig_audio
sparse_keymap irqbypass rfkill rapl video syscopyarea intel_cstate
mei_me ipmi_si sysfillrect mei intel_uncore iTCO_wdt sysimgblt pcspkr
iTCO_vendor_support dcdbas mxm_wmi ipmi_devintf lpc_ich
ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sr_mod sd_mod
cdrom t10_pi sg qede qedf crct10dif_pclmul crc32_pclmul crc32c_intel
qed ahci libahci ghash_clmulni_intel libata libfcoe libfc tg3
megaraid_sas scsi_transport_fc crc8 wmi dm_mirror dm_region_hash
dm_log dm_mod [last unloaded: tls]
[ 7305.151246] CPU: 23 PID: 35995 Comm: kworker/23:0 Kdump: loaded Not
tainted 6.4.0-rc3+ #1
[ 7305.160379] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS
2.16.0 07/20/2022
[ 7305.168832] Workqueue: qedf_io_wq qedf_fp_io_handler [qedf]
[ 7305.175069] RIP: 0010:refcount_warn_saturate+0xba/0x110
[ 7305.180911] Code: 01 01 e8 c9 4d ae ff 0f 0b c3 cc cc cc cc 80 3d
1a ae 6f 01 00 75 85 48 c7 c7 d8 e3 bb ac c6 05 0a ae 6f 01 01 e8 a6
4d ae ff <0f> 0b c3 cc cc cc cc 80 3d f5 ad 6f 01 00 0f 85 5e ff ff ff
48 c7
[ 7305.201873] RSP: 0018:ffff9cc488507e80 EFLAGS: 00010282
[ 7305.207708] RAX: 0000000000000000 RBX: ffff904a44ac7410 RCX: 0000000000000027
[ 7305.215685] RDX: ffff904e2fcdf848 RSI: 0000000000000001 RDI: ffff904e2fcdf840
[ 7305.223654] RBP: ffff9046cc488040 R08: 80000000ffff9b21 R09: 657466612d657375
[ 7305.231623] R10: 203b776f6c667265 R11: 646e75203a745f74 R12: ffff904e2fcf1880
[ 7305.239591] R13: ffffbcc47fcc7500 R14: 0000000000000000 R15: ffffbcc47fcc7505
[ 7305.247559] FS:  0000000000000000(0000) GS:ffff904e2fcc0000(0000)
knlGS:0000000000000000
[ 7305.256595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7305.263011] CR2: 0000563088c3b008 CR3: 0000000102bfc006 CR4: 00000000001706e0
[ 7305.267445] [0000:04:00.2]:[qedf_process_error_detect:1519]:11:
Error detection CQE, xid=0x743
[ 7305.270983] Call Trace:
[ 7305.280598] [0000:04:00.2]:[qedf_process_error_detect:1521]:11:
err_warn_bitmap=00000040:00000000
[ 7305.283328]  <TASK>
[ 7305.283330]  qedf_fp_io_handler+0x40/0x50 [qedf]
[ 7305.293237] [0000:04:00.2]:[qedf_process_error_detect:1525]:11:
tx_buff_off=00000000, rx_buff_off=00000000, rx_id=04ec
[ 7305.295574]  process_one_work+0x1e5/0x3f0
[ 7305.296755] [0000:04:00.2]:[qedf_process_error_detect:1519]:11:
Error detection CQE, xid=0x194
[ 7305.296761] [0000:04:00.2]:[qedf_process_error_detect:1521]:11:
err_warn_bitmap=00000040:00000000
[ 7305.296764] [0000:04:00.2]:[qedf_process_error_detect:1525]:11:
tx_buff_off=00000000, rx_buff_off=00000000, rx_id=013d
[ 7305.324202] [0000:04:00.2]:[qedf_process_error_detect:1519]:11:
Error detection CQE, xid=0x37c
[ 7305.326752]  ? __pfx_worker_thread+0x10/0x10
[ 7305.336659] [0000:04:00.2]:[qedf_process_error_detect:1521]:11:
err_warn_bitmap=00000040:00000000
[ 7305.337543] [0000:04:00.2]:[qedf_process_error_detect:1519]:11:
Error detection CQE, xid=0x47b
[ 7305.337549] [0000:04:00.2]:[qedf_process_error_detect:1521]:11:
err_warn_bitmap=00000000:00004000
[ 7305.337552] [0000:04:00.2]:[qedf_process_error_detect:1525]:11:
tx_buff_off=00000000, rx_buff_off=00000000, rx_id=06ed
[ 7305.348603]  worker_thread+0x50/0x3a0
[ 7305.358219] [0000:04:00.2]:[qedf_process_error_detect:1525]:11:
tx_buff_off=00000000, rx_buff_off=00000000, rx_id=04ed
[ 7305.362987]  ? __pfx_worker_thread+0x10/0x10
[ 7305.373920] [0000:04:00.2]:[qedf_process_error_detect:1519]:11:
Error detection CQE, xid=0x731
[ 7305.382497]  kthread+0xe2/0x110
[ 7305.382502]  ? __pfx_kthread+0x10/0x10
[ 7305.382505]  ret_from_fork+0x2c/0x50
[ 7305.382511]  </TASK>
[ 7305.382512] ---[ end trace 0000000000000000 ]---

