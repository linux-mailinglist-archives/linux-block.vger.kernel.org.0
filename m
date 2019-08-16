Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79ED903E4
	for <lists+linux-block@lfdr.de>; Fri, 16 Aug 2019 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHPOUq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Aug 2019 10:20:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46147 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfHPOUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so2505469plz.13
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fu+P3/a+1rC8rZw3Gt8TiaXxYRTXamUs9fDcY+0m0HI=;
        b=In9xW0iFA6WQomqB28O3E74hynrni7Gz1trvj0bDzhPmgmkTmp1aCpOGRP7dCnTeOp
         AgPIaWtWncH0ufUpW7I1atzs15KEkwDc9NyyeuI+82ZjxEpUtV736clbGeP6rIVuq89C
         zuWlr0Gr7NYSTygP7ELUWufE7fgFS+IwHYkpUGXcxMJpZ49P5D98d8ThJce9R8Fn+k3v
         tmZ2tCfR0tNnC39tFdCJ9eQzGx0o1r7dXbtEVx7tnueZ38sPbhfGsNtNnWytqarcYf0l
         zg5L84Wk0E2iUOE5wTSLlczPHObOPHxZu2Dwz0218eo+0Ci8pS2vFEmDsdQECawCJ00N
         aysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fu+P3/a+1rC8rZw3Gt8TiaXxYRTXamUs9fDcY+0m0HI=;
        b=A0mBGPzktqNMH1+ENcv8ngqpfmRC2L6olOCcz8iZnzY7G6aAN402xwzh1TKxg2GzlD
         iDhMxQ0XyPiFIQdxB7kPuIFzqO+1HBUM9J5OLKDb4r81WQqKBwb1OWG3g9WFRY4TqjXP
         fJRoYhbNdyOZ84xHOR0TaQgZ+UCapXepGeEgjQVFr6DtmZFAufYGoCJIiwv4obd8MpUz
         nUdRzLmWAEfy9bYFan+i2lclo9n9Vx70I/x+GtaBrVQMVfla8BzWaWAgeIBLfdwaE365
         3wD9PQ18pFlmyDItF9RR9emZaL1eGIYw1CmLY8+qJf2acT3NUio8/+FW+vlv3K3tzbOQ
         f3Cw==
X-Gm-Message-State: APjAAAV0roba2i/wjw+PyIIlCTyRieSVZna3xaA1utAieFohk3g0VMZt
        XbqSWseY8YssMQi3W+ciIB2g1w==
X-Google-Smtp-Source: APXvYqwVoge3HO3eQudhtz14WRTcXikDJEruLSRjcdra21rftjb2fcmmOiACkbGPUEkw3CWjghfVlw==
X-Received: by 2002:a17:902:760c:: with SMTP id k12mr9115512pll.206.1565965245063;
        Fri, 16 Aug 2019 07:20:45 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 143sm9039470pgc.6.2019.08.16.07.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:20:44 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove blk_mq_hw_sysfs_cpus
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Mark Ray <mark.ray@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20190816074849.7197-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5baa0c28-6e12-5a61-0254-de0e49cf1596@kernel.dk>
Date:   Fri, 16 Aug 2019 08:20:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816074849.7197-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 1:48 AM, Ming Lei wrote:
> It is reported that sysfs buffer overflow can be triggered in case
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
> blk_mq_hw_sysfs_cpus_show().
> 
> This info isn't useful, given users may retrieve the CPU list
> from sw queue entries under same kobject dir, so far not see
> any active users.
> 
> So remove the entry as suggested by Greg.

I think that's a bit frivolous, there could very well be scripts or
apps that use it. Let's just fix the overflow.

-- 
Jens Axboe

