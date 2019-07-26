Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845A6771A3
	for <lists+linux-block@lfdr.de>; Fri, 26 Jul 2019 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfGZSwm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jul 2019 14:52:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34642 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbfGZSwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:52:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so24930077pfo.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCzABlzxJIWqpdsz/GdT+dRhbjSPeoaS0a04x/C23oI=;
        b=V8ZgvfS2NU9boI60RokdHcqdt9iApmlgW1EUQz9BIhLpOOEJXfXI+uFMMiam6yXv24
         EvDuKzRJQPmeLaLhjUb4BjKKa4r5gVNYVfcA62kGbYcp6IF97rpEBlu5JT9/CwDEcOWr
         1pdyfw69lNSV7eLfOi2YBDyuxZnAWIpnvwSZdLgJ/fSaLx3VnLTykxylKHvIgEOPcINb
         HRW3aVi1a4cKKT1/fg4rYFXZhlinUqi4dV/lyzNe9PR9ZUj2TeqP9UuGkyYckLZf/k6G
         I5davdmb+EYQhbYs79r+SScrv+YOxXxa/mc1H8Nb4XNKzM7NrpaDRSfmtdxum8XptvHl
         BDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCzABlzxJIWqpdsz/GdT+dRhbjSPeoaS0a04x/C23oI=;
        b=NWwbfLVgZmrk4zCEKxaN/9UaiIjatW9hYLoA6I9rZwRDGiyz+8p9zjVrueSlYsPgyA
         ZryEYVBBoFdKcITItCCq7OVIMvukbpeqCwqjSScGDNveOf+ssPSv6fHdwM5XMjLu0v7y
         g+Oi8S0Jk90LCYf1RXTsoxGUMoG8CWzD93qvvgskfQ+xqDse63ghlu9u8XRk04nue+lW
         FbCCrY4JQr2CeUqmjYDgcgvtZIjtRrNtALZyINAtPTMB5ezxFLpXnGAXUlE85xVGNPvu
         u79j+kE6rw7fyqbNkyUMK5Lff1w+NrM2u5YvxcuTlJp5DFxyPVSESrg+w7E1pO7lQ2cy
         x0sQ==
X-Gm-Message-State: APjAAAXHpsPhi3JI3cRwPilwwjy7U1hf3hg+pRos1xyBv3JDGjwgIwcb
        ulKPMnEmP/eZ1qlJZx8mHb8ZXn6ILPc=
X-Google-Smtp-Source: APXvYqyV40BqS3R4zJ0esnZ9QpLFlNS8PphI2D6QErMz1PnYEHbFbcXd1ic6V0E/S/Yi400y1soJUA==
X-Received: by 2002:a65:6288:: with SMTP id f8mr87134148pgv.292.1564167161480;
        Fri, 26 Jul 2019 11:52:41 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id a3sm62279325pje.3.2019.07.26.11.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:52:40 -0700 (PDT)
Subject: Re: [PATCH] block: fix max segment size handling in
 blk_queue_virt_boundary
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux@roeck-us.net, James.Bottomley@HansenPartnership.com,
        linux-block@vger.kernel.org
References: <20190724162656.3967-1-hch@lst.de> <20190726073518.GA23993@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e112ef7e-e1c4-ac62-367a-dfc0cc6e1c58@kernel.dk>
Date:   Fri, 26 Jul 2019 12:52:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726073518.GA23993@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/19 1:35 AM, Christoph Hellwig wrote:
> Jens, can you take a look?  This fixes a boot regression hitting
> various people.

Sorry, totally missed this... Did already send in a pull request
today, but I'll get this applied and out before -rc2.

-- 
Jens Axboe

