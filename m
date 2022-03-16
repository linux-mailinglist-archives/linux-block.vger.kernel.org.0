Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591B84DB032
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 13:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiCPM70 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Mar 2022 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiCPM7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 08:59:25 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA4761D0D3;
        Wed, 16 Mar 2022 05:58:10 -0700 (PDT)
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 35EFB7A0222;
        Wed, 16 Mar 2022 13:58:09 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Date:   Wed, 16 Mar 2022 13:58:06 +0100
User-Agent: KMail/1.9.10
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk> <202203161228.05700.linux@zary.sk> <0015ea51-b3e9-924a-2714-61b159fc7b98@opensource.wdc.com>
In-Reply-To: <0015ea51-b3e9-924a-2714-61b159fc7b98@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <202203161358.06506.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wednesday 16 March 2022, Damien Le Moal wrote:
> On 3/16/22 20:28, Ondrej Zary wrote:
> > On Wednesday 16 March 2022, Sergey Shtylyov wrote:
> >> Hello!
> >>
> >> On 3/14/22 12:19 AM, Ondrej Zary wrote:
> >>
> >> [...]
> >>>>> The pata_parport is a libata-based replacement of the old PARIDE
> >>>>> subsystem - driver for parallel port IDE devices.
> >>>>> It uses the original paride low-level protocol drivers but does not
> >>>>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> >>>>> behind parallel port adapters are handled by the ATA layer.
> >>>>>
> >>>>> This will allow paride and its high-level drivers to be removed.
> >>>>>
> >>>>> paride and pata_parport are mutually exclusive because the compiled
> >>>>> protocol drivers are incompatible.
> >>>>>
> >>>>> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
> >>>>> chip).
> >>>>>
> >>>>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> >>>>> drivers - they don't handle non-multiple-of-4 block transfers
> >>>>> correctly. This causes problems with LS-120 drive.
> >>>>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> >>>>> or 8-bit mode is used first (probably some initialization missing?).
> >>>>> Once the device is initialized, EPP works until power cycle.
> >>>>>
> >>>>> So after device power on, you have to:
> >>>>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> >>>>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> >>>>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> >>>>> (autoprobe will initialize correctly as it tries the slowest modes
> >>>>> first but you'll get the broken EPP-32 mode)
> >>>>>
> >>>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
> >>>> [...]
> >>>>> diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
> >>>>> index e1ce90af602a..e431a1ef41eb 100644
> >>>>> --- a/Documentation/admin-guide/blockdev/paride.rst
> >>>>> +++ b/Documentation/admin-guide/blockdev/paride.rst
> >>>> [...]
> >>>>> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..783764626a27
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/ata/pata_parport.c
> >>>>> @@ -0,0 +1,819 @@
> >>>> [...]
> >>>>> +static void pata_parport_lost_interrupt(struct ata_port *ap)
> >>>>> +{
> >>>>> +	u8 status;
> >>>>> +	struct ata_queued_cmd *qc;
> >>>>> +
> >>>>> +	/* Only one outstanding command per SFF channel */
> >>>>> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
> >>>>> +	/* We cannot lose an interrupt on a non-existent or polled command */
> >>>>> +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
> >>>>> +		return;
> >>>>> +	/*
> >>>>> +	 * See if the controller thinks it is still busy - if so the command
> >>>>> +	 * isn't a lost IRQ but is still in progress
> >>>>> +	 */
> >>>>> +	status = pata_parport_check_altstatus(ap);
> >>>>> +	if (status & ATA_BUSY)
> >>>>> +		return;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * There was a command running, we are no longer busy and we have
> >>>>> +	 * no interrupt.
> >>>>> +	 */
> >>>>> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
> >>>>> +	/* Run the host interrupt logic as if the interrupt had not been lost */
> >>>>> +	ata_sff_port_intr(ap, qc);
> >>>>> +}
> >>>>
> >>>>    As I said, ata_sff_lost_interrupt() could be used instead...
> >>>
> >>> It couldn't be used because it calls ata_sff_altstatus().
> >>
> >>    And? That one used to call the sff_check_altstatus() method (which you define)
> >> even before my patch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=03c0e84f9c1e166d57d06b04497e11205f48e9a8
> > 
> > OK, I was probably confused by ata_sff_check_status which uses ioread directly.
> > 
> >> [...]
> >>>>> diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
> >>>>> new file mode 100644
> >>>>> index 000000000000..f1ba57bb319c
> >>>>> --- /dev/null
> >>>>> +++ b/include/linux/pata_parport.h
> >>>>> @@ -0,0 +1,108 @@
> >> [...]
> >>>>> +static inline u16 pi_swab16(char *b, int k)
> >>>>> +{
> >>>>> +	union { u16 u; char t[2]; } r;
> >>>>> +
> >>>>> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> >>>>> +	return r.u;
> >>>>> +}
> >>>>> +
> >>>>> +static inline u32 pi_swab32(char *b, int k)
> >>>>> +{
> >>>>> +	union { u32 u; char f[4]; } r;
> >>>>> +
> >>>>> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> >>>>> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> >>>>> +	return r.u;
> >>>>
> >>>>    Hey, I was serious about swab{16|32}p()! Please don't use home grown byte
> >>>> swapping...
> >>>
> >>> This crap comes from old paride.h and we can't get rid of it without touching the protocol drivers
> >>
> >>    I don't argue about the *inline*s themselves, just about the ineffective code inside them.
> >>
> >>> (comm.c and kbic.c). Maybe use something like:
> >>>
> >>> #define pi_swab16(char *b, int k) 	swab16p((u16 *)&b[2 * k])
> >>
> >>> but I'm not sure it's equivalent on a big-endian machine.
> >>
> >>    These functions are endian-agnostic -- they swap always.
> >>    If you only need to swab the bytes on big-endian machines, you should use cpu_to_le*() and/or
> >> le*_to_cpu()...
> > 
> > swab16 swaps always but pi_swab16 does not on big-endian. It's probably a bug but doing the correct thing by accident. Other protocol drivers completely ignore endianness, probably because PARIDE was meant for x86 only.
> 
> Fix that. ATA/IDE uses little endian. So all command & replies fields
> should be handled with put_unaligned_lexx()/get_unaligned_lexx(), or
> cpu_to_lexx() and lexx_to_cpu().

Fortunately, most of the code uses 8-bit only accesses (registers are 8-bit and also parport HW is mostly 8-bit). Only block reads/writes in EPP-16 and EPP-32 modes seem to be affected. I'll fix that later as I'm not touching protocol drivers now.

> 
> > 
> >> [...]
> >>
> >> MBR, Sergey
> >>
> > 
> > 
> > 
> 
> 



-- 
Ondrej Zary
