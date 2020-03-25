Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB04C192CFC
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCYPkt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 11:40:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38576 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgCYPkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:40:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so934272plz.5
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2020 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJQwrHc5KYK1Moq3YLhA+cPCCwDV01vQIttVxXnXwtc=;
        b=1JyTDKPiJO30x26Vu1Vfe2MkHut80Eu7Wdc4i8X+qy6dwmGmseVAFDQ6WszS+sKQ2G
         JGg7ozTNVg/8hbbXyrmJcMb34TSODC1+oR+UUqOhQNnDwVgsxbZM13xKBFAXwnURMDYh
         VedK/p7dYdTAin6MFLxB5cx80u2rLqPr8EJYYYnyIMtaWe4Ifxdsqq8qgR3BE78h6jsM
         bAM98SrCRGfZBjL5yHHGuhvvmLqXIHS9zxoC9cz11gN+PHCiyFUcxDuH0PzZozte/Sri
         CTONI7IyWiE6+Tvq3jj4sHaGO8jtye+9L1Mz8y6kR4ovsdNjyaSl5RDhXCUS0bpG5v8v
         4WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJQwrHc5KYK1Moq3YLhA+cPCCwDV01vQIttVxXnXwtc=;
        b=iCRMBg50FiwNvq7411SX1SzoBcDPLtNW4/BdaUHwLbKVKL9JBpN7FTi3SRZWRMM1zu
         Cspva4JEfqJEk8/kCAPVqU1vdPvUU3E4aLpttER1tHr0nCHK/cv5cFw3jiholvIwkyv/
         0TZHNjHJsNUktXhXir55JZiSWAb2SFg9k+vGVT+gSZ7Ri8SG0O/m8QgsVBJXurJNU7An
         JcPwmchxK5/76URW9enGbhqTMYBFsalSlEwy8WdH7XSMRdsgqZEfWub7mxqn/Lr0FLTx
         Zb4ujAGFWae8l+Vud6/4Rv4iLx58VRfiZ0ZOBWUKUPULjhmofubsMpuWAvcNK1SsDsoK
         zcSQ==
X-Gm-Message-State: ANhLgQ1fXHh3nLkruc+DpDO+9CWYwPzG8pQWJbRbcI8odNnluvYCZpIk
        STM2zSxhbDDq13DG3Yof/VEATg==
X-Google-Smtp-Source: ADFU+vt11pwSKIyZE73gAeB7bBFUnxt1iyuPeAwqagoBJzJF0qoXWAvo44C06Qoa0vIxZF23n5jzXw==
X-Received: by 2002:a17:902:9a46:: with SMTP id x6mr3879020plv.80.1585150847821;
        Wed, 25 Mar 2020 08:40:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g2sm11445369pfh.193.2020.03.25.08.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:40:46 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] block: factor out requeue handling from dispatch
 code
To:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-2-johannes.thumshirn@wdc.com>
 <20200325084030.GB11943@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <defdc64c-a83b-509d-c7d6-c8aae0cbd4a7@kernel.dk>
Date:   Wed, 25 Mar 2020 09:40:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325084030.GB11943@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/20 2:40 AM, Christoph Hellwig wrote:
> On Wed, Mar 25, 2020 at 12:24:44AM +0900, Johannes Thumshirn wrote:
>> Factor out the requeue handling from the dispatch code, this will make
>> subsequent addition of different requeueing schemes easier.
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, can you pick this up?  I think it already is a nice improvement
> even without the rest of the series.

Sure, applied for 5.7.

-- 
Jens Axboe

