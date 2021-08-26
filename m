Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710E3F8C6B
	for <lists+linux-block@lfdr.de>; Thu, 26 Aug 2021 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhHZQpZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Aug 2021 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhHZQpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 12:45:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F69C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:44:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d26so6173308wrc.0
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QeAbhlzpZVlb60rdBvitwQvZYp3X78buppk2lXRBrI0=;
        b=mEVv8zxXj5lkBJiopa3jWhmRj9sihYQ20TAAitKct9Q1SIQukbHH5OcoAleZuycYhW
         R6MNtwVwM8YZ0I4Itr2yqSMvdGLtnKTLpyNMOXEHuYCoiGdFvd2pVggzL4AMnpSo9nIg
         +SKfjU+1MDqxP6uR0CN4P0q4206F0pyf+Z3K7BDKV3UYc0jRLFG3lDF0V4Tx/K5hqGSi
         cIcV8HLFUDZXJ0GPBb83C1UXCaKO61GdCu7jEnPLkoHdAjmq0dsOOmuXFA9IPI0w3PtB
         zgygIbtcgfJxjZWyCGiKXx1mn+rAWkyk+JPp/KWC9GhCb8smmGVpMWynpzYVTbyazkeq
         mTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeAbhlzpZVlb60rdBvitwQvZYp3X78buppk2lXRBrI0=;
        b=IwLzI/AUEJihi9JOFX5CGkY01iTj2jzjTQCj9MBkw1fV9tb6pJw0sPa2KL4D0CWB8g
         0sVI6irzx2YKshimnbzMc/+r4XxcCVWfETMdbzLY06Gp9jdlPtzRavoDeuvLs6SN3dk8
         HpoyALg6EXLx0ZIb9Bhs3qyVKwrNI2TKlMAyh7o1ZCv0Sa7nF+gg+BeQ4pQlXMhxxUdm
         z/mMV7o+D2DWIBuZwStm2BLB1s61/XNAijRcvxgOCQQ0wV/NzpMPzahJJbChHLo+Nt/t
         4OiRP91jecp/uopZGha44Sqc3JYPaf42ebmLC0EfYKRZ+nZV/mSERZPI+Yc2HZWuiLhH
         OnIw==
X-Gm-Message-State: AOAM531zo6HrxLBX1xhfzRnyVGnAMuhsxPq7xPqsT76PXZ0GVYH3C7m4
        WrKJlZDYqfMw0rvVS7DHFRwYg8V3rcs=
X-Google-Smtp-Source: ABdhPJyXwm8KTv8pWBiXrffqcBENXzbx+qe7PPSXvH9bsyRVWXqtGYmG+Suncs/lWhzNYZAhDljkUw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr5254419wrz.242.1629996274492;
        Thu, 26 Aug 2021 09:44:34 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id f17sm1802591wmf.4.2021.08.26.09.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:44:34 -0700 (PDT)
Subject: Re: [PATCH 5/8] loop: merge the cryptoloop module into the main loop
 module
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
References: <20210826133810.3700-1-hch@lst.de>
 <20210826133810.3700-6-hch@lst.de>
 <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com>
 <20210826163422.GA28718@lst.de>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <ebfe4404-e251-ec0d-e46d-0a02b031bcb2@gmail.com>
Date:   Thu, 26 Aug 2021 18:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826163422.GA28718@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/08/2021 18:34, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 06:31:50PM +0200, Milan Broz wrote:
>> the cryptoloop is insecure, most of the encryption modes are deprecated
>> (and known to be problematic); util-linux no longer support cryptoloop
>> options in losetup.
>>
>> Isn't the better way to go just to remove cryptoloop completely?
> 
> I'm not sure if we're going to break existing users.  So maybe for now
> get rid of the horrible registration interface, an add a patch to
> deprecate it with a warning when people actually use it, and then
> eventually remove it. 

Yes, I know that removal is far disturbing thing here, if it
can be planned for removal later, I think it is the best thing to do...

And I would like to know actually if there are existing users
(and how and why they are using this interface - it cannot be configured
through losetup for years IIRC).

Thanks,
Milan
