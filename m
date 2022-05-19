Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66A52CDC2
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiESIAH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiESIAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 04:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C83983C;
        Thu, 19 May 2022 01:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07DC6168D;
        Thu, 19 May 2022 08:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F996C34100;
        Thu, 19 May 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652947200;
        bh=iKXW78pxSl8QpjoS8FErvoGCH4L/pjL+JqIqYVBLIQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NDg/mHX5CcWMfPFXokoFfMue+AV2uI+MQRwObYZI04jDAAkv7mlCw4z1mI3C3ymqr
         t4cmJoxon58/O5LcmYTL/84y9kRbsc7On4irBHPLFShCkA36XWD1OuisZnRJmxjbfz
         HI9MsSfUONNXDkjn6I2V8Po/BIIO5H8qKLHmMUIo/JLWpHT0iN+Sy2DJ/1DxbsallN
         kRrAW52XK8wHr8v0cnSlZg0sD7U1geJW0C3CfLy7yqvst0lOPsnYaHjU0qk8Bv1tbj
         1tdGw5h7M/gIMt7rQ2prXz0iHYI06h1+AKg3SwN16lXK7wUVTgmrFE5zzRRpvGi1lm
         q2r8lcOiCX8jA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nrb4f-00CM9g-JL; Thu, 19 May 2022 08:59:57 +0100
Date:   Thu, 19 May 2022 08:59:57 +0100
Message-ID: <87ee0q54w2.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <axboe@kernel.dk>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <paulmck@kernel.org>, <bp@suse.de>, <keescook@chromium.org>,
        <songmuchun@bytedance.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <pasha.tatashin@soleen.com>,
        <tabba@google.com>, <ardb@kernel.org>, <tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_svaddagi@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 6/6] irqchip/gic-v3: Re-init GIC hardware upon hibernation restore
In-Reply-To: <1652860121-24092-7-git-send-email-quic_vivekuma@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
        <1652860121-24092-7-git-send-email-quic_vivekuma@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: quic_vivekuma@quicinc.com, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, axboe@kernel.dk, rafael@kernel.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com, pavel@ucw.cz, paulmck@kernel.org, bp@suse.de, keescook@chromium.org, songmuchun@bytedance.com, rdunlap@infradead.org, damien.lemoal@opensource.wdc.com, pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org, tsoni@quicinc.com, quic_psodagud@quicinc.com, quic_svaddagi@quicinc.com, quic_kprasan@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Vivek,

On Wed, 18 May 2022 08:48:41 +0100,
Vivek Kumar <quic_vivekuma@quicinc.com> wrote:
> 
> Code added in this patch takes backup of different set of
> registers during hibernation suspend. On receiving hibernation
> restore callback, it restores register values from backup. This
> ensures state of hardware to be same just before hibernation and
> after restore.
> 
> Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
> Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 138 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 2be8dea..442d32f 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -29,6 +29,10 @@
>  #include <asm/smp_plat.h>
>  #include <asm/virt.h>
>  
> +#include <linux/syscore_ops.h>
> +#include <linux/suspend.h>
> +#include <linux/notifier.h>
> +
>  #include "irq-gic-common.h"
>  
>  #define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
> @@ -56,6 +60,14 @@ struct gic_chip_data {
>  	bool			has_rss;
>  	unsigned int		ppi_nr;
>  	struct partition_desc	**ppi_descs;
> +#ifdef CONFIG_HIBERNATION
> +	unsigned int enabled_irqs[32];
> +	unsigned int active_irqs[32];
> +	unsigned int irq_edg_lvl[64];
> +	unsigned int ppi_edg_lvl;
> +	unsigned int enabled_sgis;
> +	unsigned int pending_sgis;
> +#endif

This is either way too much, or way too little. Just restoring these
registers is nowhere near enough, as you are completely ignoring the
ITS, so this will leave the machine broken for anything that requires
LPIs.

But If the bootloader is supposed to replace the kernel to put the HW
in a state where the GIC is usable again, why do we need any of this?

Hibernation relies on a basic promise: the secondary kernel is entered
with the HW in a reasonable state, and the basic infrastructure
(specially for stuff that can be only programmed once per boot such as
the RD tables) is already available. If the bootloader is going to do
the work of the initial kernel, then it must do it fully, and not
require this sort of random sprinkling all over the shop.

Effectively, there is an ABI between the primary kernel and the
secondary, and I don't see why this interface should change to paper
over what I see as the deficiencies of the bootloader.

Am I missing anything?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
