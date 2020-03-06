Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4132217B499
	for <lists+linux-block@lfdr.de>; Fri,  6 Mar 2020 03:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFCoU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Mar 2020 21:44:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17186 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCFCoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:44:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e61b8d70000>; Thu, 05 Mar 2020 18:43:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Mar 2020 18:44:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Mar 2020 18:44:17 -0800
Received: from [10.2.167.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Mar
 2020 02:44:17 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
 <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
 <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
 <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com>
 <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com>
 <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com>
 <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com>
 <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com>
Date:   Thu, 5 Mar 2020 18:44:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583462616; bh=DKBFgPSaV8pfaDbSKHc7SyDQ3J8wcKXFLItQ3hzg2EM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=f60kWRoFcrHD0jRNWdK+O2/JI5W+qtVb7vHCPNqz9ZAlTDetTLJV1484m6zaVdTsB
         c7gAucDZYpA6vTGdVptxzft8OmheZZMmsgTtglG9xcgpERFOiowUF5+mFiJuEWpmIG
         5u3npusggJ/jgSL9hiOJbRbynswFPFjJdUWWlNM9qncpiOGOVh1E1XA0UzVLTKawIF
         7tjGNQ9LGhH7r9b3JOL5WyAEJqBM/qQhEzp+O84UYu0+HfRoPgHSI9rUKSSgKr90mb
         dLTwT3OLGg3iiAMkK/UFQxmwd51kIaeNkvXmtfV+jpozHCl7Wd/qWhJYjYxWKkjLWP
         aX0D5xONB9LAA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/5/20 5:05 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 5 Mar 2020 at 01:20, Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>>
>> On 3/4/20 2:35 PM, Sowjanya Komatineni wrote:
>>> On 3/4/20 9:51 AM, Sowjanya Komatineni wrote:
>>>> On 3/4/20 9:26 AM, Sowjanya Komatineni wrote:
>>>>> On 3/4/20 9:21 AM, Sowjanya Komatineni wrote:
>>>>>> On 3/4/20 8:56 AM, Sowjanya Komatineni wrote:
>>>>>>> On 3/4/20 2:18 AM, Ulf Hansson wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> So, from my side, me and Anders Roxell, have been collaborating on
>>>>>>>>> testing the behaviour on a TI Beagleboard x15 (remotely with
>>>>>>>>> limited
>>>>>>>>> debug options), which is using the sdhci-omap variant. I am
>>>>>>>>> trying to
>>>>>>>>> get hold of an Nvidia jetson-TX2, but not found one yet. These
>>>>>>>>> are the
>>>>>>>>> conclusions from the observed behaviour on the Beagleboard for the
>>>>>>>>> CMD6 cache flush command.
>>>>>>>>>
>>>>>>>>> First, the reported host->max_busy_timeout is 2581 (ms) for the
>>>>>>>>> sdhci-omap driver in this configuration.
>>>>>>>>>
>>>>>>>>> 1. As we all know by now, the cache flush command (CMD6) fails with
>>>>>>>>> -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set
>>>>>>>>> to 30 *
>>>>>>>>> 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
>>>>>>>>> from the command.
>>>>>>>>>
>>>>>>>>> 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
>>>>>>>>> the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
>>>>>>>>> timeout_ms parameter is less than max_busy_timeout (2000 < 2581).
>>>>>>>>> Then everything works fine.
>>>>>>>>>
>>>>>>>>> 3. Updating the code to again use 30s as the
>>>>>>>>> MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY
>>>>>>>>> to be
>>>>>>>>> set, even when the timeout_ms becomes greater than
>>>>>>>>> max_busy_timeout.
>>>>>>>>> This also works fine.
>>>>>>>>>
>>>>>>>>> Clearly this indicates a problem that I think needs to be
>>>>>>>>> addressed in
>>>>>>>>> the sdhci driver. However, of course I can revert the three
>>>>>>>>> discussed
>>>>>>>>> patches to fix the problem, but that would only hide the issues
>>>>>>>>> and I
>>>>>>>>> am sure we would then get back to this issue, sooner or later.
>>>>>>>>>
>>>>>>>>> To fix the problem in the sdhci driver, I would appreciate if
>>>>>>>>> someone
>>>>>>>>> from TI and Nvidia can step in to help, as I don't have the HW
>>>>>>>>> on my
>>>>>>>>> desk.
>>>>>>>>>
>>>>>>>>> Comments or other ideas of how to move forward?
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> Hi Ulf,
>>>>>>>>>
>>>>>>>>> I could repro during suspend on Jetson TX1/TX2 as when it does
>>>>>>>>> mmc flush cache.
>>>>>>>> Okay, great.
>>>>>>>>
>>>>>>>>> Timeout I see is for switch status CMD13 after sending CMD6 as
>>>>>>>>> device side CMD6 is still inflight while host sends CMD13 as we
>>>>>>>>> are using R1 response type with timeout_ms changes to 30s.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Earlier we used timeout_ms of 0 for CMD6 flush cache, and with
>>>>>>>>> it uses R1B response type and host will wait for busy state
>>>>>>>>> followed by response from device for CMD6 and then data lines go
>>>>>>>>> High.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Now with timeout_ms changed to 30s, we use R1 response and SW
>>>>>>>>> waits for busy by checking for DAT0 line to go High.
>>>>>>>> If I understand correctly, because of the timeout now set to 30s,
>>>>>>>> MMC_RSP_BUSY becomes disabled in __mmc_switch() for your case in
>>>>>>>> sdhci-tegra as well?
>>>>>>> Yes
>>>>>>>> In other words, mmc_poll_for_busy() is being called, which in your
>>>>>>>> case means the ->card_busy() host ops (set to sdhci_card_busy() in
>>>>>>>> your case) will be invoked to wait for the card to stop signal
>>>>>>>> busy on
>>>>>>>> DAT0.
>>>>>>>>
>>>>>>>> This indicates to me, that the ->card_busy() ops returns zero to
>>>>>>>> inform that the card is *not* busy, even if the card actually
>>>>>>>> signals
>>>>>>>> busy? Is that correct?
>>>>>>> Yes
>>>>>>>>>
>>>>>>>>> With R1B type, host design after sending command at end of
>>>>>>>>> completion after end bit waits for 2 cycles for data line to go
>>>>>>>>> low (busy state from device) and waits for response cycles after
>>>>>>>>> which data lines will go back high and then we issue switch
>>>>>>>>> status CMD13.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> With R1 type, host after sending command and at end of
>>>>>>>>> completion after end bit, DATA lines will go high immediately as
>>>>>>>>> its R1 type and switch status CMD13 gets issued but by this time
>>>>>>>>> it looks like CMD6 on device side is still in flight for sending
>>>>>>>>> status and data.
>>>>>>>> So, yes, using R1 instead of R1B triggers a different behaviour, but
>>>>>>>> according to the eMMC spec it's perfectly allowed to issue a CMD13
>>>>>>>> even if the card signals busy on DAT0. The CMD13 is not using the
>>>>>>>> DATA
>>>>>>>> lines, so this should work.
>>>>>>>>
>>>>>>>> If I understand correctly, your driver (and controller?) has issues
>>>>>>>> with coping with this scenario. Is it something that can be fixed?
>>>>>>>>
>>>>>>>>> 30s timeout is the wait time for data0 line to go high and
>>>>>>>>> mmc_busy_status will return success right away with R1 response
>>>>>>>>> type and SW sends switch status CMD13 but during that time on
>>>>>>>>> device side looks like still processing CMD6 as we are not
>>>>>>>>> waiting for enough time when we use R1 response type.
>>>>>>>> Right, as stated above, isn't sdhci_card_busy() working for your
>>>>>>>> case?
>>>>>>>> Can we fix it?
>>>>>>> sdhci_card_busy() returned 0 indicating its not busy.
>>>>>>>
>>>>>>> Based on our host design, When CMD6 is issued with R1 type, we
>>>>>>> program it as NO_RESPONSE and with this command complete interrupt
>>>>>>> happens right at end bit of command and there will be no transfer
>>>>>>> complete interrupt.
>>>>>> *[Correction] Based on our host design, When CMD6 is issued with R1
>>>>>> type as we program it as NO_RESPONSE and with this command complete
>>>>>> interrupt happens right at end bit of command and there will be no
>>>>>> transfer complete interrupt.
>>>>> Sorry to correct wordings, I meant sdhci driver programs response
>>>>> type as NO_RESPONSE for CMD6.
>>>>>
>>>>> When CMD6 is issued with R1 type and as NO_RESPONSE, Based on our
>>>>> host design  command complete interrupt happens right at end bit of
>>>>> command and there will be no transfer complete interrupt.
>>>>>
>>>>>
>>>> Sorry for confusion. Please ignore above on response. it is using
>>>> SHORT response for R1. So SW poll should be working.
>>>>
>>>> Will get back on checking on host design side internally.
>>>>
>>> Hi Ulf,
>>>
>>> Verified internally regarding the busy state over DATA0 Our host
>>> design has known minor bug where command complete interrupt is
>>> asserted after waiting for busy cycles from device.So because of this
>>> polling for card_busy() returns 0 (DAT0 line High) immediately as
>>> waiting for busy is taken care during command complete interrupt in
>>> host design. This behavior is same for R1 and R1B.
>>>
>>>
>>>>>>> When CMD6 is issued with R1B type, we program is as R1B RESP_SHORT
>>>>>>> and with this command complete is end bit of device resp and
>>>>>>> transfer complete interrupt will be when DAT0 LOW -> HIGH.
>>>>>>>
>>>>>>> Regardless of R1/R1B, device side CMD6 will always have busy state
>>>>>>> on D0 and response on CMD lines.
>>>>>>>
>>>>>>> There will be 2 clock cycles period after sending CMD6 for device
>>>>>>> to send busy state on data0.
>>>>>>>
>>>>>>> In case of R1 type, after sending command DAT will stay high and
>>>>>>> looks like we are polling for busy early before busy state has
>>>>>>> started and sending CMD13 while device is busy and sending
>>>>>>> response on CMD line is causing timeout.
>>>>>>>
>>>>>>> Probably with this specific case of CMD6 with R1 type, to wait for
>>>>>>> card busy we should poll for DAT0 to go Low first and then to go
>>>>>>> High??
>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Actually we always use R1B with CMD6 as per spec.
>>>>>>>> I fully agree that R1B is preferable, but it's not against the
>>>>>>>> spec to
>>>>>>>> send CMD13 to poll for busy.
>>>>>>>>
>>>>>>>> Moreover, we need to cope with the scenario when the host has
>>>>>>>> specified a maximum timeout that isn't sufficiently long enough for
>>>>>>>> the requested operation. Do you have another proposal for how to
>>>>>>>> manage this, but disabling MMC_RSP_BUSY?
>>>>>>>>
>>>>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
>>>>>>>> then what timeout would the driver be using if we would set
>>>>>>>> cmd.busy_timeout to 30ms?
>>>>>>>>
>> Sorry didn't understood clearly. Are you asking with 30s timeout, whats
>> the data timeout counter used?
> Yes. It seems like it will pick the maximum, which is 11s?
yes
>
>> Because of above mentioned issue on our host where CMD interrupt happens
>> after busy state, poll for busy returns right away as not busy.
> I see.
>
>> So issuing CMD13 after CMD6-R1 followed by busy poll should be working.
>> But weird that with small delay of 1ms or debug print before CMD13 it
>> doesn't timeout and works all the time.
> I have digested the information you provided in these emails. Let me
> summarize it, to see if I have understood correctly.
>
> 1.
> Your controller can't distinguish between R1 and R1B because of a
> limitation in the HW. So, in both cases you need to wait for the card
> to stop signal busy, before the controller can give an IRQ to notify
> that the R1 response has been received. Correct?
>
> In this context, I am wondering if sdhci_send_command(), really
> conforms to these requirements. For example, depending on if the CMD6
> has MMC_RSP_BUSY or not, it may pick either SDHCI_CMD_RESP_SHORT or
> SDHCI_CMD_RESP_SHORT_BUSY.
>
> Does this work as expected for your case?
Design team re-verified internally and bug where HW waits for busy state 
before IRQ is only for R1B and R1 is spec compliant.

So, with R1, CMD complete is generated after response received.

With R1B, CMD complete and xfer complete both are generated after 
response received + device busy (max timeout of 11s)
DATA timeout interrupt will be asserted incase if HW busy detection fails.

With R1B we may see DATA Timeout if operation takes more than max busy 
timeout of 11s.

> 2.
> Assuming my interpretation of the above is somewhat correct. Then you
> always need to set a busy timeout for R1/R1B responses in the
> controller. The maximum timeout seems to be 11s long. Obviously, this
> isn't enough for all cases, such as cache flushing and erase, for
> example. So, what can we do to support a longer timeouts than 11s?
> Would it be possible to disable the HW timeout, if the requested
> timeout is longer than 11s and use a SW timeout instead?
>
> Kind regards
> Uffe

For erase long operations we have register bit to enable for infinite 
busy wait mode where host controller would be monitoring until card is busy.

But so far for emmc devices we used on our platforms, we haven't seen 
cache flush taking more than 11s.

Will get back on possibility of disabling HW timeout and using SW timeout..

Thanks

Sowjanya

