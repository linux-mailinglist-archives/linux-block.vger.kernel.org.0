Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137705F3EB9
	for <lists+linux-block@lfdr.de>; Tue,  4 Oct 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJDIqe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Oct 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJDIqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 04:46:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD511171
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 01:46:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w10so4994036edd.4
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=HZoJTFXSFHDtHhNw6iBj6A0OPafEqOsoBdKA5eFD4Ok=;
        b=ZVELRqWk/WMKzFh2oehBclvnckSFiF5A54SIOShB2TNifxLIG8WxfTleY/+lJFwfbp
         FH3YGmc9nufROuVReEBeoq0EiAh8ZsTMCFMngW6CPFRNAoNYhSOq65xiCrW6L7ejW56E
         1DJGKHs5W0ozsuVPgJ0udMfK8pLhjn8fE1ZifVG9awxRTzpuEhwlvlRkbR9lUNDEYLI5
         pPCz8mJlQETSk4T90SQ7Q98P6BGzdxL3zHLaHMpG4cO69Hcl7Py7BZG+Nu9bKN/yfjmW
         y5KWVPo+rAbq2wa6Ddx86Y9QdE920Gj30I+j+XgMJlJCMytUoWJb0hDdcUeQKAAQxI9Z
         szjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HZoJTFXSFHDtHhNw6iBj6A0OPafEqOsoBdKA5eFD4Ok=;
        b=1QHmzfOZkvAWl+wU66Z9WY+IKip1SsSceCVa2Nu2MWzLUY4fO8kHT2k9HuD1+10jlv
         avTc3vuyCUmpBTWC9oOShaHlUTK47bXw95FZKvYH1pqd6JNRj2k+1+hy+z+7zjAQV+EG
         6uUrtNWU424DwMOT1nKlDMLzZTSMfhlgHqAj2Kryc8ypGZtD9cXEHtjku0dJibGzdk7J
         C5m2nNaZSF5j0yhdMxhd4vp4I3kC7ik3PUp/XRQfhf/2NxGVX7XH6L4nFSFAHD2AMhGX
         uOsK4XvlKg37NqfScjSUMlUEUzgrirCwxqPFHrVnwfNc11uCvsKGmp06SZJf83hdCLnQ
         a2cA==
X-Gm-Message-State: ACrzQf1ww3QLkLBWQfa9SbDJT+6LxDh7pqT6uSDCbUPJPxuBp86oV5+J
        HjpgiyJC4Mev8RTfB6uwk0ikGw==
X-Google-Smtp-Source: AMsMyM5AL0r2DOPUaYa8+QoxkjeC5tklSdteEh6rBmXSFvB6AVxgAaC40NtpI644GUJdkG1z7lDq9g==
X-Received: by 2002:aa7:d614:0:b0:458:f796:f86a with SMTP id c20-20020aa7d614000000b00458f796f86amr8675763edr.294.1664873189449;
        Tue, 04 Oct 2022 01:46:29 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b00781d411a63csm6610619ejo.151.2022.10.04.01.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:46:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: block: wrong return value by bio_end_sector?
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7b36f881-1423-c01d-c584-806d1741081d@wdc.com>
Date:   Tue, 4 Oct 2022 10:46:27 +0200
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFB9C449-8E8B-4BBE-AC1E-11F82703E5F3@linaro.org>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
 <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
 <51C3A1EA-A746-4DA2-AFC1-D9C4C1D7B213@linaro.org>
 <7b36f881-1423-c01d-c584-806d1741081d@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 3 ott 2022, alle ore 00:33, Damien Le Moal =
<Damien.LeMoal@wdc.com> ha scritto:
>=20
> On 2022/10/03 1:20, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 1 ott 2022, alle ore 02:50, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>>=20
>>> On 10/1/22 00:59, Paolo Valente wrote:
>>>> Hi Jens, Damien, all other possibly interested people, this is to =
raise
>>>> attention on a mistake that has emerged in a thread on a bfq =
extension
>>>> for multi-actuary drives [1].
>>>>=20
>>>> The mistake is apparently in the macro bio_end_sector (defined in=20=

>>>> include/linux/bio.h), which seems to be translated (incorrectly) as=20=

>>>> sector+size, and not as sector+size-1.
>>>=20
>>> This has been like this for a long time, I think.
>>>=20
>>>>=20
>>>> For your convenience, I'm pasting a detailed description of the=20
>>>> problem, by Tyler (description taken from the above thread [1]).
>>>>=20
>>>> The drive reports the actuator ranges as a starting LBA and a count =
of
>>>> LBAs for the range. If the code reading the reported values simply =
does
>>>> startingLBA + range, this is an incorrect ending LBA for that =
actuator.
>>>=20
>>> Well, yes. LBA 0 + drive capacity is also an incorrect LBA. If the =
code
>>> assumes that it is, you have a classic off-by-one bug.
>>>=20
>>>> This is because LBAs are zero indexed and this simple addition is =
not
>>>> taking that into account. The proper way to get the endingLBA is
>>>> startingLBA + range - 1 to get the last LBA value for where to =
issue a
>>>> final IO read/write to account for LBA values starting at zero =
rather
>>>> than one.
>>>=20
>>> Yes. And ? Where is the issue ?
>>>=20
>>>>=20
>>>> Here is an example from the output in SeaChest/openSeaChest:=20
>>>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>>>=20
>>>> Range#     #Elements            Lowest LBA          # of LBAs 0
>>>> 1                                               0
>>>> 17578328064 1            1                         17578328064
>>>> 17578328064
>>>>=20
>>>> If using the incorrect formula to get the final LBA for actuator 0, =
you
>>>> would get 17578328064, but this is the starting LBA reported by the
>>>> drive for actuator 1. So to be consistent for all ranges, the final =
LBA
>>>> for a given actuator should be calculated as starting LBA + range - =
1.
>>>>=20
>>>> I had reached out to Seagate's T10 and T13 representatives for
>>>> clarification and verification and this is most likely what is =
causing
>>>> the error is a missing - 1 somewhere after getting the information
>>>> reported by the device. They agreed that the reporting from the =
drive
>>>> and the SCSI to ATA translation is correct.
>>>>=20
>>>> I'm not sure where this is being read and calculated, but it is not =
an
>>>> error in the low-level libata or sd level of the kernel. It may be =
in
>>>> bfq, or it may be in some other place after the sd layer. I know =
there
>>>> were some additions to read this and report it up the stack, but I =
did
>>>> not think those were wrong as they seemed to pass the drive =
reported
>>>> information up the stack.
>>>>=20
>>>> Jens, Damien, can you shed a light on this?
>>>=20
>>> I am not clear on what the problem is exactly. This all sound like a
>>> simple off-by-one issue if bfq support code. No ?
>>=20
>> Yes, it's (also) in bfq code now; no, it's not only in bfq code.=20
>>=20
>> The involved bfq code is a replica of the following original function
>> (living in block/blk-iaranges.c):
>>=20
>> static struct blk_independent_access_range *
>> disk_find_ia_range(struct blk_independent_access_ranges *iars,
>> 		  sector_t sector)
>> {
>> 	struct blk_independent_access_range *iar;
>> 	int i;
>>=20
>> 	for (i =3D 0; i < iars->nr_ia_ranges; i++) {
>> 		iar =3D &iars->ia_range[i];
>> 		if (sector >=3D iar->sector &&
>> 		    sector < iar->sector + iar->nr_sectors)
>> 			return iar;
>> 	}
>>=20
>> 	return NULL;
>> }
>>=20
>> bfq's replica simply contains also this warning, right before the =
return NULL:
>>=20
>> 	WARN_ONCE(true,
>> 		  "bfq_actuator_index: bio sector out of ranges: =
end=3D%llu\n",
>> 		  end);
>>=20
>> So, if this warning is triggered, then the sector does not belong to
>> any range.
>>=20
>> That warning gets actually triggered [1], for a sector number that is
>> larger than the largest extreme (iar->sector + iar->nr_sectors) in =
the
>> iar data structure.  The offending value resulted to be simply equal
>> to the largest possible value accepted by the iar data structure, =
plus
>> one.
>>=20
>> So, yes, this is an off-by-one error.  More precisely, there is a
>> mismatch between the above code (or the values stored the iar data
>> structure) and the value of bio_end_sector (the latter is passed as
>> input to the above function).  bio_end_sector does not seem to give
>> the end sector of a request (equal to begin+size-1), as apparently
>> expected by the above code, but the sector after the last one =
(namely,
>> begin+size).
>>=20
>> Should I express an opinion on where the error is, I would say that
>> the mistake is in bio_end_sector.  But I could be totally wrong, as
>> I'm not a expert of either of the involved parts.  In addition,
>> bio_end_sector is already in use, with its current formula, by other
>> parts of the block layer.  If you guys (Damien, Jens, Tyler?, ...)
>> give us some guidance on what to fix exactly, we will be happy to =
make
>> a fix.
>=20
> I do not think there is any error/problem anywhere with =
bio_end_sector(). But
> indeed, the name is slightly misleading as it doe not return the last =
sector
> processed by the bio but the next one. The reason is that with this
> implementation, bio_end_sector() always gives you the first sector for =
the next
> bio with a multi-bio request.
>=20
> When you need the last sector processed by the bio, you need to use
> bio_end_sector(bio) - 1.
>=20
> So to find the access range that served a completed bio, you simply =
need to call:
>=20
> disk_find_ia_range(iars, bio_end_sector(bio) - 1);
>=20

Thank you very much, I got it now.

> You probably could add a couple of helper functions for getting an =
access range
> from a bio sector or end sector. Something like:
>=20
> static inline struct blk_independent_access_range *
> __bio_sector_access_range(struct bio *bio, sector_t sector)
> {
> 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
>=20
> 	if (!disk->ia_ranges)
> 		return NULL;
>=20
> 	iar =3D disk_find_ia_range(disk->ia_ranges, sector);
> 	WARN_ONCE(!iar,
> 		  "bfq_actuator_index: bio sector out of ranges: =
end=3D%llu\n",
> 		  end);
>=20
> 	return iar;
> }
>=20
> static inline struct blk_independent_access_range *
> bio_sector_access_range(struct bio *bio)
> {
> 	return __bio_sector_access_range(bio, bio_sector(bio));
> }
>=20
> static inline struct blk_independent_access_range *
> bio_end_sector_access_range(struct bio *bio)
> {
> 	return __bio_sector_access_range(bio, bio_end_sector(bio) - 1);
> }
>=20
> or similar. Then your code will be simpler and much less worries about =
of-by-one
> bugs.
>=20

For the moment, bio_end_sector is invoked in only one place (for the
range-computation stuff).  So, for simplicity, I'd go for just
appending a -1 after such invocation.  To give you credits, I'm adding
you in a reviewed-by tag.  If anything of this is wrong, I'm willing
to change it.  I'll send a V2 soon.

Thanks,
Paolo

>>=20
>> Thanks,
>> Paolo
>>=20
>>=20
>>=20
>>>=20
>>>>=20
>>>> Thanks, Paolo
>>>>=20
>>>> [1] https://www.spinics.net/lists/kernel/msg4507408.html
>>>=20
>>> --=20
>>> Damien Le Moal
>>> Western Digital Research
>>=20
>>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research

