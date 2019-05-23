Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4482274B4
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2019 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEWDPL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 May 2019 23:15:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44147 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfEWDPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 23:15:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so2316546pgp.11
        for <linux-block@vger.kernel.org>; Wed, 22 May 2019 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZK7j7zv97j63SQM68a4YW/4h0ifyYGqPf1dLQhN71IQ=;
        b=fvEN8CcluSeiHextpppycHa49vSKIDT/L5s3wFLxUz9U73eLo2O2/mb1KBcviQmqOy
         OrHXhCS0l515yo69tle0qlVHoD/tfMaXeAwKnLWvEnsbpvB4L44s2XFsaobGYYTFXqch
         vQO0XwFiKmeVuU8jBUuXg1FOkv0I2DQI/b8dL7gWeVbgW+JrL6eF0X44DQwd6c3fY71B
         0s0ZqarpkxMP1l0KhPCAcss+g/d5H7eIDw0QbF80ZPPCMZ8OAg8gV4vbLSHMyeDMLDE/
         KgVPRNwNGW0QnGL0IfRps6Hxwi0K9EgerYk0OBpEkfQwr7plg3dFeO/HSWIImqCtnQhm
         xrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZK7j7zv97j63SQM68a4YW/4h0ifyYGqPf1dLQhN71IQ=;
        b=GGuuFzjcbo7eGV1zkoJ/YD3y95bPyYq/Ky5sRJZsAzIuvr02hi+u/yuB1yYWYEaWgr
         V+A7l3GfHgwSJF2N90v/SrlPSwR+j/5kdF/My7sbtEb/s8TJYRrCfF/NzcBlPveSNbwP
         TgMogPIUxDw9VQrJtXQRgy+lb8kH/Bh2B09kG1QlJX+S93QnDd0UgqVHil0qqfOT8AiI
         y5QdD+xkpkGBDkdt/xItMD9dh+wG1DkLPnQUJmU4cBPqg1br2etQla9rmFXmEgkXCF1E
         FHAloKd4xZkujg8IXPEoe93XyjbIsESxTSG/sz3Z4Wxj1bVDw7B/k+pvYFQCePGfL4Jk
         7u8Q==
X-Gm-Message-State: APjAAAV6uZQkWWNMJHQNX9k5g1zSyHI0mx9ef5voeEZYTFo2HOSStq1w
        TcEJj3VOy+rF+ZCxVCUV6NlW1zpEx9s1VQ==
X-Google-Smtp-Source: APXvYqxqspCGzHAZA2WV1GxTVUh5XTOFylfORDb1ZIkeq9PmCUiMYBjFIVVP+vLncIzxOChb/TahBQ==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr7132275pfh.56.1558581310422;
        Wed, 22 May 2019 20:15:10 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i22sm29275623pfa.127.2019.05.22.20.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 20:15:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] io_uring: free memory immediately when io_mem_alloc
 failed
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22018663-fe73-eed5-3e21-3d5a525f88bc@kernel.dk>
Date:   Wed, 22 May 2019 21:15:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/19 7:59 PM, Jackie Liu wrote:
> In extreme cases, memory may not be available. so we should
> be clean up memory.

The caller frees these on error.

-- 
Jens Axboe

