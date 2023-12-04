Return-Path: <linux-block+bounces-673-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4580322F
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4DC1F20FD9
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2842375F;
	Mon,  4 Dec 2023 12:10:53 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671FD2;
	Mon,  4 Dec 2023 04:10:49 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rA7mh-0000e8-Iq; Mon, 04 Dec 2023 13:10:47 +0100
Message-ID: <17bd838f-12a0-43c2-a45c-46021083170b@leemhuis.info>
Date: Mon, 4 Dec 2023 13:10:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block/badblocks.c warning in 6.7-rc2
Content-Language: en-US, de-DE
To: Coly Li <colyli@suse.de>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 Linux RAID <linux-raid@vger.kernel.org>,
 Linux bcachefs <linux-bcachefs@vger.kernel.org>, Xiao Ni <xni@redhat.com>,
 Geliang Tang <geliang.tang@suse.com>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Janpieter Sollie <janpieter.sollie@edpnet.be>
References: <562a2442-d098-4972-baa1-5a843e06b180@gmail.com>
 <C8305655-3749-411B-A696-E07E95882215@suse.de>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <C8305655-3749-411B-A696-E07E95882215@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701691849;400920e5;
X-HE-SMSGID: 1rA7mh-0000e8-Iq

On 29.11.23 09:08, Coly Li wrote:
>> 2023年11月29日 07:47，Bagas Sanjaya <bagasdotme@gmail.com> 写道：
>>
>> I notice a regression report that is rather well-handled on Bugzilla [1].
>> Quoting from it:
>>
>>>
>>> when booting from 6.7-rc2, compiled with clang, I get this warning on one of my 3 bcachefs volumes:
>>> WARNING: CPU: 3 PID: 712 at block/badblocks.c:1284 badblocks_check (block/badblocks.c:1284) 
>>> The reason why isn't clear, but the stack trace points to an error in md error handling.
>>> This bug didn't happen in 6.6
>>> there are 3 commits in 6.7-rc2 which may cause them,
>>> in attachment:
>>> - decoded stacktrace of dmesg
>>> - kernel .config
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218184
> 
> It seems the improved bad blocks code caught a zero-size bio request
> from upper layer, this improper behavior was silently neglected before.
> It might be too early or simple to decide this is a regression,

Well, it's often better to add an issue to the tracking even if there is
a chance that it's not a real regression, as the issue might otherwise
fall through the cracks. But given...

> especially Janpieter closes the report for now.

...this I agree that this is likely not worth tracking, hence:

#regzbot inconclusive: maybe not a regression and report can not
reproduce it anymore

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

