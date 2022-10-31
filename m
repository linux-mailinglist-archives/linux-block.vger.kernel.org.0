Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEA61300E
	for <lists+linux-block@lfdr.de>; Mon, 31 Oct 2022 06:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJaF7Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Oct 2022 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaF7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 01:59:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494C235
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667195954; x=1698731954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vflxvR+XmHinY4eo+kW8luvLFnoJAGpWj7D2G8z6iqY=;
  b=HFdbrsHInuEmCasQQqxT7zjoyFo7M39bLLgTIyjmPqvTnxg4sGN5ifMk
   bcxFkbY06wOZ4JKLldWuKk6JbDvRY02ieegV197f0KIYVoW4jfazsrtVm
   27w0Hee9pNVf7mWVm6NQ343dUGPIZzNAJ6LJdzugTvncv1G0byqfen9pn
   /LLBAnmvwbI5Fl87A5fh1AKw75Z+TsVXvKHc0Vl0N91Z/Q6PEibYLe6tN
   VnCp7m2xIDIrCLDME+6xha31UBbz2bNFo7ZultWeUegs8wnvq7/U1Sit9
   NNOf1mYtlv8p91RNnrzndUMDukgTIx6mGFDySCfY+7ZgkvnJwroUVbGuo
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327211886"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 13:59:13 +0800
IronPort-SDR: wF+zINpyRu/7Ob+AnbcaMfgD7TLxST9JouOIdSEumIDeFXW/fL68JMoqHNSkDUCwnJh+bnNTAe
 vIl44k8+CIDjVYpDFRwnB+zfpJvcxUN7KxSd0LvrrsaWE47ntdHSj3sXGFNpxzvZBqFcv8jRzU
 L3ggUqjU3eXdiVoAGYXwTShKkMCRovwZ0ezdQpVAp+JwvOBStGk91ENhqejSUL/HHKumz03X98
 Mjec/nsMpCE+2o+zj28HHkJbHKMXwcixqe/t3JQQGCOyiX+vA++hfmUy/7ncqm2LAHfdWOuV7d
 Qv2PKMDicosXjQDv08qZwruL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 22:18:30 -0700
IronPort-SDR: 3mY7Mn/WLljqMawhEkg+oirEaGcNzWsr0iK/ryiR5DO+SmTe4zozNqt/9qxZiZBeNqsoCwZMNP
 DI39sz5aXCCtBRIEZHMWbO86V4/R2pfoze2nam4M9RyvH/TnQrJxlGf7Jso/AlJyJyKYSOU9yv
 b3QR7I7WkrmQE7LMABhNnpnqt0FbWvuYAEAVLUaYmCLNcyv68/O+sjbLs8WEmG106861HhXoMr
 OA/raXj/RIPWVlF/E03T+wNI/dt6ePBgwx0YWwoGI+xksevXAINbDOgDg3rdNdi8EHazcRZJgV
 5TA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 22:59:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N12Xd23Zqz1Rwtm
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 22:59:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667195951; x=1669787952; bh=vflxvR+XmHinY4eo+kW8luvLFnoJAGpWj7D
        2G8z6iqY=; b=H02X05Nc5tOuE3JXs4n77QIv/Xo8bqtOuonWSzLhWTJrbwuHfJU
        rBM3DK91ao4A206v8Q7Hb4hJUi7KuRHK2zKYP71ZAdnlj7L9TET3o4OwHK4xjiSc
        aEIM+H7pbVfQZJ3jfyZOu8awE5rr16sgpfUMrrxQl4A6R6YSmYiCf+ou1kdVuORF
        1m+EDr+/BB1MZUKIK6GC4UKLHyq+8sGLlP5DqCRJAV9BlbB7It97aCsX2ZU6/YBG
        kX4L6+gsV3GFHq3j6QragTw1u+PR4nr6ovbIX+Hj5WFS9t9tUS349z76hVoq6wRk
        DRILbfL3BD/Nef5snKndVDJl2aj71F1c1gg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7D_ToT5_txty for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 22:59:11 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N12XY1nGYz1RvLy;
        Sun, 30 Oct 2022 22:59:09 -0700 (PDT)
Message-ID: <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
Date:   Mon, 31 Oct 2022 14:59:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
 <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 17:33, John Garry wrote:
> On 28/10/2022 09:07, Damien Le Moal wrote:
>>> Well, yeah. So if some error happens and EH kicks in, then full queue
>>> depth of requests may be allocated. I have seen this for NCQ error. So
>>> this is why I make in very first patch change allow us to allocate
>>> reserved request from sdev request queue even when budget is fully
>>> allocated.
>>>
>>> Please also note that for AHCI, I make reserved depth =1, while for SAS
>>> controllers it is greater. This means that in theory we could alloc > 1x
>>> reserved command for SATA disk, but I don't think it matters.
>> Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that
>> the
>> user can only use 31 tags ? or is it 32+1 reserved ? which we can do
>> since
>> when using the reserved request, we will not use a hw tag (all reserved
>> requests will be non-ncq).
>>
>> The 32 + 1 scheme will work. 
> 
> Yes, 32 + 1 is what we want. I now think that there is a mistake in my
> code in this series for ahci.
> 
> So I think we need for ahci:
> 
> can_queue = 33

Hmm.. For ATA, can_queue should be only 32. nr_tags is going to be 33
though as we include one tag for a reserved command. No ? (may be I
misunderstand can_queue though).

> nr_reserved_cmds = 1
> 
> while I only have can_queue = 32

Which seems right to me.

> 
> I need to check that again for ahci driver and AHCI SHT...
> 
>> But for CDL command completion handling, we
>> will need a NCQ command to do a read log, to avoid forcing a queue drain.
>> For that to reliably work, we'll need a 31+1+1 setup...
>>
> 
> So is your idea to permanently reserve 1 more command from 32 commands ?

Yes. Command Duration Limits has this weird case were commands may be
failed when exceeding their duration limit with a "good status" and
"sense data available bit" set. This case was defined to avoid the queue
stall that happens with any NCQ error. The way to handle this without
relying on EH (as that would also cause a queue drain) is to issue an
NCQ read log command to fetch the "sense data for successful NCQ
commands" log, to retrieve the sense data for the completed command and
check if it really failed or not. So we absolutely need a reserved
command for this, Without a reserved command, it is a nightmare to
support (tag reuse would be another solution, but it is horrible).

> Or re-use 1 from 32 (and still also have 1 separate internal command)?

I am not yet 100% sure if we can treat that internal NCQ read log like
any other read/write request... If we can, then the 1-out-of-32
reservation would not be needed. Need to revisit all the cases we need
to take care of (because in the middle of this CDL completion handling,
regular NCQ errors can happen, resulting in a drive reset that could
wreck everything as we lose the sense data for the completed requests).

In any case, I think that we can deal with that extra reserved command
on top of you current series. No need to worry about it for now I think.

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

