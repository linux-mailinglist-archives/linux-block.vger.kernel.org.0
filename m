Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C36184A86
	for <lists+linux-block@lfdr.de>; Fri, 13 Mar 2020 16:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMPVo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Mar 2020 11:21:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33193 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgCMPVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 11:21:43 -0400
Received: by mail-io1-f66.google.com with SMTP id r15so9742276iog.0
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2020 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5dDfozKhzejuOUugvF5ilqDnV48Q57wyrdkGrqBYbWw=;
        b=NiSScCeXAIzypIPanR8Bq6oQORzQS4XTaJNsYAKpLXS3hsKNEZdD4nG4HkptjcalIV
         yMRFNoYZq4IBBP0Nb9/3wfOMq3TE6uJ/JFoWEFIvIsOfPNQF/SaQ3tEodKFm4OybZ/Gc
         AJil7M/aXeaQndkH6Z0+BqnWOJEPV2j9bQujg3xUNEU/f2VBMFQBfLzDF11LmxjQ/JrB
         EEEO3VEAxq+N1SqlUWW66hBzQjdf7c/NaIHJDupQ+y6YThI2Evs3IjTvq1lp8gkHHC2+
         3rLjCOEQO2/ILU66qCnupZx8U34PeVfNaJvLx633MBP9y4Er56t27iPqrURszxcFuP5T
         ue0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5dDfozKhzejuOUugvF5ilqDnV48Q57wyrdkGrqBYbWw=;
        b=eqnMB1qwt+4WkQJEZVTlcxHZVb/ZuxWqc5siyVkAVa2Jgc4jHavgWdX7G1RKztV81M
         qMWeo9Uben2RyAADnlM+tERVcgjFrr1PZoRRe2PEbIl3KjygXigy/i8AvMpXpgzwCdZf
         4yQlx2MOkqK8gsri2HVAbKrYJzexdhHUaDbw8K0g+xUYsTJGzAEdnIW4HKqo3ZMvcOGw
         UsOUr4GYW7UpjVP6S4L0UXa3O8xpqwsxUWzJjzBg7oArtnWJ07zm2mJPcoBWi7P1/5pR
         BifNdL7+lv5oT9Wd8n8OUcJZ6MgcHz5RjDFQXPUc4Ecn/expndgFGNqW9OC1Ean2o5Ny
         BhWg==
X-Gm-Message-State: ANhLgQ3nno/Yk+0evZ7NTJs7vy+JxIunhf54AudzjK2SQtWwsqLDB6Gr
        pttYINJLSVylXHO5vlVVInIgJph2W5hvrA==
X-Google-Smtp-Source: ADFU+vsf0zgxppL8gMgdpNhRxKHCCyhKtsWRmQM1u/iLAzpP7jvAtz9Cf54kEM3hc/YxUwddVSVvMA==
X-Received: by 2002:a02:ab92:: with SMTP id t18mr13970659jan.69.1584112901117;
        Fri, 13 Mar 2020 08:21:41 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f69sm6142725ilg.10.2020.03.13.08.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:21:40 -0700 (PDT)
Subject: Re: [PATCH] sata_fsl: fixup compilation errors
To:     Hannes Reinecke <hare@suse.de>
Cc:     Guenther Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
References: <20200313151722.74659-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50f5c462-e68d-ad99-4a76-bb72a126d43d@kernel.dk>
Date:   Fri, 13 Mar 2020 09:21:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313151722.74659-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/20 9:17 AM, Hannes Reinecke wrote:
> Fixup compilation errors introduced by the libata DPRINTK rewrite.

How many more are we going to uncover? There's no excuse for not
having even compiled this stuff, seriously.

-- 
Jens Axboe

