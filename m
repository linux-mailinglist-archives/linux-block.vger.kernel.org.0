Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA8891E5
	for <lists+linux-block@lfdr.de>; Sun, 11 Aug 2019 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHKNrY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 11 Aug 2019 09:47:24 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38503 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfHKNrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Aug 2019 09:47:21 -0400
Received: by mail-pg1-f170.google.com with SMTP id z14so10954528pga.5
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2019 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKL1dA155QCu6WYrg0VrgaVF1x3BPFSyhRdmz8vLW5g=;
        b=p2tu4E4X7s81MRwfV968FP5zSv+IZkMFZa/KVtay3OLVJ1mqT6IMqCCZhnuIGTAoMQ
         UnqjNXTSubbJTUxUoz6J68iuBG4+dhtyAj6PcBhjcx1PH9NtPkm1abxJQ73avVAZeOJ1
         VXYoyC8CG0Qy6FJz2J9CYFtoTNELIQ+qMlwf52gZ/EhTr9l6jOaXVKYjdaMyK9nTdvxk
         P6IeLoTamnbJ/xJwB8kCgFXjLoiahqQReE4Rdt76EUt2H2ffVHkrMH6Z+FKXtovHKfuq
         xjdtEqmhiTQWFBo81uR3XjPAs03z4vTUtSrDvXFxqW5Q1BhQUq3I/BevvE7sDTnI3rgZ
         hbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKL1dA155QCu6WYrg0VrgaVF1x3BPFSyhRdmz8vLW5g=;
        b=AiaYL5OSGeyUqH3NbxiGhpvEem0Hctg6r9d1VZNmPnUzVFEZTs4mzqvt6lzstOxvnu
         Z/bJjOTWESneZbko2ljHMoKpVLIHolMolk94Bk1H94IrN8KHs4oYUboWZZDCwwJUSANr
         /kUoaIyf+u3iQVcwCEtCCXHuFZg+6PXkpfs4l4RcHefpMxhSupeqgA8H2+ONLL2p5jph
         k/1t+KyeZlMCJiLZi5VQ3dZlkaJzQcByMlr9I6KNYsM+ovWXPEJi08wIxzNXQIgtjl3i
         q1z6D46qApasV3RlFT+C+FIfTyXrWEXPoodSxj87CIHiNvhXF9puwQDyzh9/IpLpa7eP
         BePA==
X-Gm-Message-State: APjAAAXx4Zd+2pkJYw16ekTyWEuK2qXfchutxU2Utgi4DwXMTb7Fn4E0
        bE+Co+yM3Oz4Tg1DASgp6eBPXEMM+65YLQ==
X-Google-Smtp-Source: APXvYqxIGqIKdUE8+57ofBw5l8grr/0GPy0neLSmHefZqohaJwNu6RjqIkrC6ao1tj7ncQD1Z2+KNg==
X-Received: by 2002:a17:90a:94c3:: with SMTP id j3mr1151182pjw.10.1565531240464;
        Sun, 11 Aug 2019 06:47:20 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 131sm33085239pge.37.2019.08.11.06.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:47:19 -0700 (PDT)
Subject: Re: [PATCHv2 0/4] blk_execute_rq{_nowait} cleanup part1
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, linux-block@vger.kernel.org
References: <20190809105433.8946-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55246cff-6d32-e7d5-bee0-9940bc59250a@kernel.dk>
Date:   Sun, 11 Aug 2019 07:47:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809105433.8946-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/19 3:54 AM, Marcos Paulo de Souza wrote:
> After checking the request_queue argument of funtion blk_execute_rq_nowait, I
> now added three more patches, one to remove the same argument from
> blk_execute_rq and other two to change the at_head argument from
> blk_exeute_rq_{nowait} from int to bool.
> 
> Original patch can be checked here[1].
> 
> After this patch gets merged, my plan is to analyse the usage the gendisk
> argument, is being set as NULL but the majority of callers.
> 
> [1]: https://lkml.org/lkml/2019/8/6/31

Don't ever send something out that hasn't even been compiled. I already
detest doing kernel-wide cleanup changes like this, but when I do, I
need absolute confidence in it actually being tested. The fact that it
hasn't even been compiled is a big black mark on the submitter.

-- 
Jens Axboe

