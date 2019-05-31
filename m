Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9731333
	for <lists+linux-block@lfdr.de>; Fri, 31 May 2019 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaQ6M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 31 May 2019 12:58:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQ6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 12:58:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id x7so3254336plr.12
        for <linux-block@vger.kernel.org>; Fri, 31 May 2019 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F0vX2aH+Cp9LCLu37gd+YCJhwNeceGHv8BjFxgYFcXY=;
        b=XJcTxUvcHoir01ox7VFX9ByXbUGpG471APznhWy8Xh8vnDZZCDWJ2eiZpleVgm35ES
         TSkL/HZk0QEQTenkPEyTrWXLANl+GhlW6HJKrHSpTIlY5+wQDOU/rFRa3cMjbMULEK6r
         vtZnrY0OP7a/RB/wHZkoGzAo4NYNY4d74c7hpgPQzxr8hbIyaePQlAVrRBYFPtqItn4Q
         IIdUFSI8Us7JpQe7fZ4wibGwU9ADgtfLaP7ePpE90FfbfnJm/SlB+TZvBgA2ExTWun2E
         F7lNyMdBc6TIUiGCEP97f1zgR9TbP8C7lOxkCn0ORyl15JmLI9qLHtsqaj7B3EOzsbgl
         f8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0vX2aH+Cp9LCLu37gd+YCJhwNeceGHv8BjFxgYFcXY=;
        b=Dyu6/GowoO+WRbFnw86/RqeIaLNYaRkhWBBmTntlAKUoVjo3dLZhgGRer3mkS/Fvns
         6/yjWhko9ms52CVNnGJ/aq/jisKfTnUaK5kBQ7EoPIo10HWbQ1tkIqSqC6kbV+IQZASS
         aHEcxkkpM5P4XThwCI8g2dGvVqaC5IPTX+llkDfSRoWF7A0TETskct0fAyUgaqHREIHO
         rORzCyetU7zx/NDchHfEJrEno4/4tBrZP+MR9YSSfk3IySSa58WFHqcw4kHyaCXx91xB
         YKIw7g20/62FxF7fGdw7RIskulTy/PnE6fvSK0Zjq5FkmKunvSnuVcbduLtV+VC9NlOX
         KVZg==
X-Gm-Message-State: APjAAAUVaqpmnmu+h9ymDDXvaTidrIJIdqagSsPME0NCHg7zUXL9/5+R
        cTIga/W/9U54zAelvlSyTJ6LeA==
X-Google-Smtp-Source: APXvYqyOovB0r3ysFlKzmRmtV+pPKmONbw+gv4oC0fDhxcTdbrDWLwucjf1B/wuc2aNQe7qE1DMxDg==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr10588724pla.33.1559321891990;
        Fri, 31 May 2019 09:58:11 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id a64sm5016419pgc.53.2019.05.31.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:58:10 -0700 (PDT)
Subject: Re: [PATCH 0/8] Improve block layer function documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190531000053.64053-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f97c1c4b-b5f6-8bfc-bd11-2907a8953e46@kernel.dk>
Date:   Fri, 31 May 2019 10:58:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/19 6:00 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> This is a series with eight patches that address source code comments. Most
> patches suppress kernel-doc warnings that appear when building with W=1. Please
> consider these patches.

Thanks Bart, applied.

-- 
Jens Axboe

