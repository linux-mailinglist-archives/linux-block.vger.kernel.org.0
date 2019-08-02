Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAA7FAF1
	for <lists+linux-block@lfdr.de>; Fri,  2 Aug 2019 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392045AbfHBNgG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Aug 2019 09:36:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391995AbfHBNgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 09:36:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so33679284plr.12
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8Y9uplBuADagAyvawsaUNa9HXTJPGyWYVF88FZ4+As=;
        b=qZuLfLa03ZGjHUp+mSTrXfUPgOUd6d2KkKGEoBnrKEKT6zDDDYEmG9aghc4CXfnQGZ
         qHJIen0GKvy2T1wgzdrbXdOHRvrnhYP08YcLe9FCXVWkW0mmm3XKtIZnxTGAT9DbuQAt
         NgMccFAo2o8ymX6Z9i8KbpTVPBKm+0ELS5dMDKfSljtd/x0tWfTtGuVUseJma/ePr4DA
         vES22y2WZeGfab/gkWFAh9SFMi8qgWJkP9wHfb0yeWKSk4lOc43b8a5kB9tY6T9WQmuk
         T6QMSbhNBIug8qZkcmj9t69LjPqjIfTUB1SwZ0YzwsFvYfPbqRFru/Lu8O1atY5AaXP0
         +Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8Y9uplBuADagAyvawsaUNa9HXTJPGyWYVF88FZ4+As=;
        b=Tmnguyyv8CPban4RYK888O49cR8vmMpgRecrMVJFzFvWcz1p4k2RfuKZin2mML8hvu
         6le3Mnt2slMO/3AT6eQ+moN338rWE05blV0BFjSJCVvXXjl/LX6sNxLbqFsO36C0S2LS
         9CPs/W6EvL4v/dfd9l56GdCzGUBds29xbIiouRs+vYFMYGBF3+vqJzUE60lhXFrlwIgM
         Q2MY28Ph/hXMjXRHoUZAt4a0J7bOO92DcPeZmGK7wQrkDomatm9b77tidxyMwv0ojBHp
         phNzbm5VttQ4/cCNneyIpA7RBk+FadzZd4st5pmQP6v6hkJYPCpEjsj32AK2mR89gQsp
         w0Lw==
X-Gm-Message-State: APjAAAWxGG42WLLdtwrT0tmHAnzYIxbwUOiLtwL42s8WLLRfhAIorcuT
        WamVLk9Vd8nU79vxAzmU9oE=
X-Google-Smtp-Source: APXvYqwHCXHkwZ99ryFpG7gfKHaVnODQLsDoPHdfWyE/HSaQSIRVIYXzaiJLTr1myB8/pahX4P4DaA==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr1759361plp.59.1564752962127;
        Fri, 02 Aug 2019 06:36:02 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id o129sm52040543pfg.1.2019.08.02.06.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:36:01 -0700 (PDT)
Subject: Re: [PATCH] block: Fix a comment in blk_cleanup_queue()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
References: <20190801223955.141237-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6533b14a-d258-e9aa-e0b0-8c8380439879@kernel.dk>
Date:   Fri, 2 Aug 2019 07:35:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801223955.141237-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 4:39 PM, Bart Van Assche wrote:
> Change a reference to the legacy block layer into a reference to blk-mq.

Applied, thanks.

-- 
Jens Axboe

