Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B657FD61
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2019 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfD3QCH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Apr 2019 12:02:07 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:52252 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3QCH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:02:07 -0400
Received: by mail-it1-f182.google.com with SMTP id x132so5506037itf.2
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w33iHm/NIDtoRjKE7zCkCFMXmgKclArP4aM0hTCBvkg=;
        b=zVOFqbOJMDduG7Z12jn5jgnfC+x1VXyTO5Oi6rszRaN5l0ZZCkUrY5g38sMAB9bdX4
         iTQDSpXHLp9FJOYuNo5F0OzQLo2/bc3Dn/JsbyGJexzkmPS52di4DJbjKsskjKeSO5c9
         dVnKY6ybpGeVyER96CHofgFOgaQMccNR00ucvW0y7RgpN0v9jzsuzTM4Bf2pMg3lJyX6
         GCPM/u7t9fQN+JMFDbhR5lbPOI6tQ6f2J+Ns3CsFeIu6ZRGacz3hE61RHCZgmAAR4Zd/
         xQ4zvIMtxMm0YUKSSC057n2/c16cX6ngj8XBgHM/p+IZuI6yD/ufL1d0rUQ0aFLSnpOT
         ZJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w33iHm/NIDtoRjKE7zCkCFMXmgKclArP4aM0hTCBvkg=;
        b=Wkpk58cIWRXj5HZ3DxtdYZE9J4nQcz3cRUqirl2DV4yoHKjid4FqjdsMJQccKlVkzj
         v6IzU7LXPvfF3KBh3eqMOkOcCGB2+SI2E3/WW4dBAUTtn2OXSPtxOpiH9VXR0qJ/1cDS
         NgPowR87rPWEHQfk4RNp0zv9Vgyf7n989tm35b/DD2cY2rJCIkmvdjp7QNFOp1J99KYg
         WhxL6fabjpLJoPWRWllRQFOSC60HnRSH4zVr0BPZ8x2umQc7JXVGpx75RjtWJXXPbh8X
         wJv7caK+E1oQ57ooiOzBft7SR3K7p/tFUvjIw+HcC5lGeeUN9WpbnLpkDzzE8vZ0VOX9
         iV3A==
X-Gm-Message-State: APjAAAUZj/K6UkfkQHwfLccTbPRRG+QvV3cL0UAkJD7zbhzYbuPbbFmD
        iDYQ7xwA5bQ0VWQ6+EyB3syHWQ==
X-Google-Smtp-Source: APXvYqxgk0EOn6NJ7vvNtNmAqSwkT68MIv/OsZt6v4wN1GPgeSBLuNv9FLDGeeni2GVPapjp1g25WQ==
X-Received: by 2002:a24:61cc:: with SMTP id s195mr4147717itc.142.1556640126719;
        Tue, 30 Apr 2019 09:02:06 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k3sm4860485iob.47.2019.04.30.09.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:02:05 -0700 (PDT)
Subject: Re: io_uring: submission error handling
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
 <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ce7be42-4183-b441-9a26-6b3441ed5fef@kernel.dk>
Date:   Tue, 30 Apr 2019 10:02:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/19 9:50 AM, Stefan Bühler wrote:
> Hi,
> 
> On 24.04.19 00:07, Jens Axboe wrote:
>> On 4/23/19 2:31 PM, Jens Axboe wrote:
>>>> 1. An error for a submission should be returned as completion for that
>>>> submission.  Please don't break my main event loop with strange error
>>>> codes just because a single operation is broken/not supported/...
>>>
>>> So that's the case I was referring to above. We can just make that change,
>>> there's absolutely no reason to have errors passed back through a different
>>> channel.
>>
>> Thinking about this a bit more, and I think the current approach is the
>> best one. The issue is that only submission side events tied to an sqe
>> can return an cqe, the rest have to be returned through the system call
>> value. So I think it's cleaner to keep it as-is, honestly.
> 
> Not sure we're talking about the same.
> 
> I'm talking about the errors returned by io_submit_sqe: io_submit_sqes
> (called by the SQ thread) calls io_cqring_add_event if there was an
> error, but io_ring_submit (called by io_uring_enter) doesn't: instead,
> if there were successfully submitted entries before, it will just return
> those (and "undo" the current SQE), otherwise it will return the error,
> which will then be returned by io_uring_enter.
> 
> But if I get an error from io_uring_enter I have no idea whether it was
> some generic error (say EINVAL for broken flags or EBADF for a
> non-io-uring filedescriptor) or an error related to a single submission.
> 
> I think io_ring_submit should call io_cqring_add_event on errors too
> (like io_submit_sqes), and not stop handling submissions (and never
> return an error).
> 
> Maybe io_cqring_add_event could then even be moved to io_submit_sqe and
> just return whether the job is already done or not (io_submit_sqes
> returns the new "inflight" jobs, and io_ring_submit the total number of
> submitted jobs).

I think we are talking about the same thing, actually. See below patch.
This changes it so that any error that occurs on behalf of a specific
sqe WILL trigger a completion event, instead of returning it through
io_uring_enter(). io_uring_enter() can still return -ERROR for errors
that aren't specific to an sqe.

I think this is what you had in mind?

Totally untested, will do so now.

-- 
Jens Axboe

