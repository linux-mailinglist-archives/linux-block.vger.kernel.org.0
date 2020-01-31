Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4841814F199
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2020 18:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAaRvl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 31 Jan 2020 12:51:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52774 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgAaRvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 12:51:40 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so3153624pjb.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9morG74SiE1BEVstgLWMuyFKqCRGMEdjkzxvFXmpcD0=;
        b=CIaZGdfglzOsX7b59cSP0qGFhRUdIjMzNt8xFFTtRHEjpE66NgZR4yoPd6nOyiRntC
         aa6RzuKKdX8/CpB38SYgQC2hNHqn2ntahTMjUY1DTCBctWPDM1i+bGth5HQWpI6fnicJ
         WsJrFcLADie7fMSN9fzsbw2UCKVfMQFeUTqKEJ9xaxJQGaeiV2MICvCuN41eRMatTULM
         AxZbhyxA+OiW+SXdiDl40CukkG9NAGbrF+oPafg8kddyPg16+HyXWZGcGAI6eAW950ou
         yPUZvy+Vh9zDABP+jceamzeAn7EZqd3xGvpQLwr6x8iM3nm4LHfQOW9ehd6bOLin+NiS
         ICjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9morG74SiE1BEVstgLWMuyFKqCRGMEdjkzxvFXmpcD0=;
        b=YRyrTdEX0FHRf4cnMNOaVW3UHW+0izzibnY8Zl2kcUYManKjolmYHCvqeMrarT7w8l
         uiC764eRCu1UwMt000Uy+28LvztJV7NjETheR33xOr+uRj9IvzsfiQknKRpT9jkwaslh
         /oe+wvIVaL1Zhwf0+NGROd+Zt3KUFxxorTUlcq3UdTi650a8Li+s44j7BcmFH4N3jLJu
         +pBfHF/MQ2J3CKpBcGz8w4OdT6xQF3Z8qV7+xkXRgtS9I0f2RGBjvd91Ij6k4u7jtwKc
         TBdy4gEjrLr3ppkpXEl4YDEg1tqDeII9+rXZyTOkk802PpGJY5ztURDDIUfwvRTzLK3p
         Rlvw==
X-Gm-Message-State: APjAAAWe6P9MvajMkpxOREzZYkpzxej2TCdEC6G+l9V2tgXR+lengpY/
        A8Ja0qE82pJCGOJDcqYtfQHmIA==
X-Google-Smtp-Source: APXvYqxx4oQy4hNaBbUqKMxo5sIJyOZhEPpwqT7h8wyObgjpS1vOjvOe7nxOemR5e3zHm7fywVyxJw==
X-Received: by 2002:a17:90a:23a3:: with SMTP id g32mr13801072pje.134.1580493100068;
        Fri, 31 Jan 2020 09:51:40 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1371? ([2620:10d:c090:180::d1ba])
        by smtp.gmail.com with ESMTPSA id n2sm11795831pfq.50.2020.01.31.09.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 09:51:39 -0800 (PST)
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <20200131174926.GC29820@ziepe.ca>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ebf3ca0-2539-5c39-09ce-c1b31fd6c3b7@kernel.dk>
Date:   Fri, 31 Jan 2020 10:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131174926.GC29820@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/20 10:49 AM, Jason Gunthorpe wrote:
> On Fri, Jan 31, 2020 at 10:04:10AM -0700, Jens Axboe wrote:
>> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
>>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
>>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
>>>>
>>>> since we didn't get any new comments for the V8 prepared by Jack a
>>>> week ago do you think rnbd/rtrs could be merged in the current merge
>>>> window?
>>>
>>> No, the cut off for something large like this would be rc4ish
>>
>> Since it's been around for a while, I would have taken it in a bit
>> later than that. But not now, definitely too late. If folks are
>> happy with it, we can get it queued for 5.7.
> 
> I'm still sore from taking the last big driver too late and getting
> about 2 weeks of little bug fixes from all the cross-arch compilation
> and what not :)

Definitely, it's one of those things that I'd want in for-next for at
least 2 weeks. Too risky to take now.

-- 
Jens Axboe

