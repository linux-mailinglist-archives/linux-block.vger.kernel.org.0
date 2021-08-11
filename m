Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C13E86AA
	for <lists+linux-block@lfdr.de>; Wed, 11 Aug 2021 01:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbhHJXrW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Aug 2021 19:47:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56358 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhHJXrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 19:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628639219; x=1660175219;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dPGMvByzWLSxA0BgxLV93qSge/w5rLHLRxcrSB2fbiw=;
  b=A2BP/Bfi4VvFOcKxoO/wvN/KUNmv6dzcXrjWFtTKbiL3uRjRcM77YV9t
   kZV3edyozu1ARrSsukUzHzQrtY+Io9t6A4DqvTu64AxSfXRdsJ+jhVPgh
   xSARRha9OVFutlhgnHyodx+pnfFxKGRhAtCIX5N/yDzQDmLmfLe3RX3sR
   WS90VrY0ctzlFWMSbORBVEUWFTggEd7HrbtOmlg3mYbx2dI8yrjbV/PfG
   vwC4//5l8yQO/UQLNdaeGsoHO4DfzPN9l37hX4vf3rTLtjvSNCMJKXQU0
   Bd93S99eyTi16frZt7g8MHHJIrj50qXk7lEI8I9Jfb/s1afZkvvbMn54c
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="280695924"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 07:46:58 +0800
IronPort-SDR: L5IAR5nDmT1aI6f3EXneZSz7DwrU0qLE9aslRDtHTL5EFB5ZITp1hSXc1Wi2bXLPbgZen3rVbF
 ycVygdoaXqmk9BTo/7+8N8Rz0mLQMmO+W3hlYPN0YIhD648VCri+vlJR5UHq5kXGJsjUBEryHV
 O26BqECLIfJOSTaaacLylBUXxkh41gb2piwKnlUlAjRPMhm5m1HFouNFaLzM/psUa+ILJhJIeH
 f8HEslmLqH1ayUVTj0jRDxNvqd32rCJ7gBX9MNe9BDUKmdkhkc1/MC61Zk0bsS66mOfJUb+r8d
 QSa/LlyLEdpPmQt2xSn3KiJg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 16:22:30 -0700
IronPort-SDR: OerXOKff18Zvlm64RW1pcN5YjH8676cci6p+v8eJVncnqOow7LMzjEClrOOPXLJ5amDjaBRuQD
 TliEtEaGk6FH66GOg/vhrBvMP37LE6Kxix5P4ly0KlweNFNuDVBviF6CdNqsgHbQTWSPWpQXhW
 Hi6IKVrzRfW6MiEhiFjhsF9PHsC/7/DrONVCORIfkN3IZaGJ7rTYpiFMUNy/D6OWYMvq6ffMrF
 XFPsvi96BxBN4A/u+RbnSaDeXIf7l/b52sGWFl/+3XkFG8RCu9nWDNJA2Tdj6M50+lMW48GYoc
 SSQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 16:46:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4GkqNy4fthz1RvlZ
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 16:46:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1628639217; x=1631231218; bh=dPGMvByzWLSxA0BgxLV93qSge/w5rLHLRxc
        rSB2fbiw=; b=gJ7ul+K+FWvNcdf/DOrzzIHFG6GSprQDLR51xnRKt0On3Mm2mcR
        R2tnigERLAk7Fbr6LzcqftziZhrYdvn3kMqMy1Eyx1rlRudZZJ1VRVcdMu1MFXJw
        BxiY6gajZwaxWZfHda21G9hSNteP4owBxZwwpRFb5rNADoMtApb4/OoBkVaVddQF
        eRNoyPIxTH0Dvr588T3xP/Mqh2oKtwUQ9I0kG53af/8VKsqLpvQq3Sz0gHn5zBWM
        y0M12vHno2dhAECL0l0+DVHb0DwweL8Dvl3nYPpuyElSVtXZ+OYsnxaZB3xX2q2Q
        ZjF5PlrgrqPkeBhn7H0/6Ja1lel99Fr/Z3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XbpIqExT7R-T for <linux-block@vger.kernel.org>;
        Tue, 10 Aug 2021 16:46:57 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4GkqNw3xCJz1RvlC;
        Tue, 10 Aug 2021 16:46:56 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] block: Add concurrent positioning ranges support
To:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20210726013806.84815-1-damien.lemoal@wdc.com>
 <20210726013806.84815-2-damien.lemoal@wdc.com>
 <YRI3kMc39XPRLe/u@infradead.org>
 <DM6PR04MB7081844211DF94238A3FC6B4E7F79@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YRKjGeOZLVnTjQNv@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <53369ff7-017e-d72e-7eb6-418d6e258074@opensource.wdc.com>
Date:   Wed, 11 Aug 2021 08:46:54 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRKjGeOZLVnTjQNv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/11 1:02, hch@infradead.org wrote:
> On Tue, Aug 10, 2021 at 11:03:41AM +0000, Damien Le Moal wrote:
>>>> + * Dummy release function to make kobj happy.
>>>> + */
>>>> +static void blk_cranges_sysfs_nop_release(struct kobject *kobj)
>>>> +{
>>>> +}
>>>
>>> How do we ensure the kobj is still alive while it is accessed?
>>
>> q->sysfs_lock ensures that. This mutex is taken whenever revalidate registers
>> new ranges (see blk_queue_set_cranges below), and is taken also when the ranges
>> are unregistered (on revalidate if the ranges changed and when the request queue
>> is unregistered). And blk_crange_sysfs_show() takes that lock too. So the kobj
>> cannot be freed while it is being accessed (the sysfs inode lock also prevents
>> it since kobj_del() will take the inode lock).
> 
> Does it?  It only protects the access inside of it, but not the object
> lifetime.

Alloc & free of the cranges structure (the top kobj) are under the
q->sysfs_lock, always. With the accesses also under that same lock, this is
mutually exclusive and all protected. Furthermore, the crange
kobj_add()/kobj_del() do a kobj_get()/kobj_put() on the parent kobj, which is
the request queue kobj. So the queue cannot go away under the crange struct.

I can add a kobj_get/put for the crange struct, but I really do not see the need
for that. Or am I missing something ?

>>>> +void blk_queue_set_cranges(struct gendisk *disk, struct blk_cranges *cr)
>>>
>>> s/blk_queue/disk/
>>
>> Hmmm... The argument is a gendisk, but it is the request queue that is modified.
>> So following other functions like this, isn't blk_queue_ prefix better ?
> 
> Do we have blk_queue_ functions that take a gendisk anywhere?  The
> ones I noticed (and the ones I've recently added) all use disk_.

The only one I can find is blk_queue_set_zoned(), which we could probably rename
to disk_set_zoned(). There are blk_revalidate_disk_zones() and blkdev_nr_zones()
which also take a gendisk and could probably be renamed as
disk_revalidate_zones() and disk_nr_zones() for consistency.

Will rename to disk_set_cranges().

-- 
Damien Le Moal
Western Digital Research
