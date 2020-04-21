Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF31B2B1A
	for <lists+linux-block@lfdr.de>; Tue, 21 Apr 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDUPXY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUPXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 11:23:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B3C061A10;
        Tue, 21 Apr 2020 08:23:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t8so4743881qvw.5;
        Tue, 21 Apr 2020 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OG6A1jRYYqPSmMaTzEw16/A1Bcu4nZISBy/88lFWE84=;
        b=oCTLEGPR9mXoGyzRTKA8Mekf+odzSlBbGAJScxkacWMjSTFAk6B3ABJ17Pbys7jKn4
         aSw9Q7aYhRp2vAkcPH384Z3WuGcSpB3WToFKY+9o/J974L5FrwDMroGZR8koKQQqBMXa
         ybPmTfbxHaNtUHw6bap1grCFoa3B5fdEPF3PjyUmQ80sUnt9mFbQW+y/seFhKPo/hZuT
         pnxKNUeo4cJMXpUcfYgyYxqKuF0YjBRRHHGDaAIsmLh+npa9okkaKcbCp9OBl0VSJQVw
         rd+bQ4uMZdL6SFMLEwQ0+JxT9RRoNcNOeuev4oZ/j+KTx4vBsuhLWQ3CNmnJ0G9fbo6Z
         O7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=OG6A1jRYYqPSmMaTzEw16/A1Bcu4nZISBy/88lFWE84=;
        b=RSVKqiPCIECeaTqEBrgaU50Jr9Qcj/r471hJHsMjuPITjMFUeZyCCG2zyrKOP4LhMV
         C/s+Av6frdT2E8uG7ny4k9wO1Njki0S8EBKbrmftQeIVGmUbMm5y+iFLmr38Ahb5U5HY
         3QR63df2qcXW3YN/EA56dzoSCPIGC2KwGbKgWrkRb0JyiPpKHG0Syj4ih232BApFO2yt
         Cc/r/tQsfPz7QGzEi/LKtdqGY5zsCs/TG0kMwzVKnhe3CjunsMIgnSJItTbccgi+Z6Ws
         7H3if/u+/Wc5YmufBOqamOaS9SLAAD8WbrtSWJjBxxO//SOqpNbSNLBlJZ/WBLkUcBRA
         KRWg==
X-Gm-Message-State: AGi0PuYu9aHuNb5078SxZmu9RIRBcs4OQ2srgocVMDPHgfi9kjOGMBzB
        GlJauQxu7Ag3TrYfkOvr2O8=
X-Google-Smtp-Source: APiQypIFjEG81MJ2KZ1F5DcGMqpb8mQqZqmnRhJZunNpX5a+p8tvT/NRkBH5hCIFm7uUmJSg1ia9hg==
X-Received: by 2002:a05:6214:16c8:: with SMTP id d8mr17794531qvz.93.1587482603265;
        Tue, 21 Apr 2020 08:23:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6b75])
        by smtp.gmail.com with ESMTPSA id d23sm1900612qtj.9.2020.04.21.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:23:22 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:23:21 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
Message-ID: <20200421152321.GB5462@mtj.thefacebook.com>
References: <20200421130755.18370-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421130755.18370-1-longman@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 09:07:55AM -0400, Waiman Long wrote:
> Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
> argument of the iocost_ioc_vrate_adj trace entry defined in
> include/trace/events/iocost.h leading to the following error:
> 
>   /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8:
>   error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
>    , u32[]* __tracepoint_arg_missed_ppm
> 
> That argument type is indeed rather complex and hard to read. Looking
> at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
> the argument to a simple "u32 *missed_ppm" and adjusting the trace
> entry accordingly, the compilation error was gone.
> 
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
