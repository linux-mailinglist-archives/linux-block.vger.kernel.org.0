Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14D1555595
	for <lists+linux-block@lfdr.de>; Wed, 22 Jun 2022 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiFVU5i (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Jun 2022 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiFVU5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 16:57:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CE19031
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 13:57:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eq6so18284337edb.6
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ElFrXwSwCVPRAW+hNoFiRlLykLfaXSBn/Xpo3VMfLLk=;
        b=Efok5NV3PznOUwdj5HBUpm2llYRESRyUMgoC5pD+Wpp8dirSeZAM0D9mHNp9LkA4lL
         cnSkDRGmKIczuA/wDuTFdlJmu3SmVKE0YChzqmYSM58BjHAH16OF6pqIK9W32YqipqmX
         dI8JR8genlIiRMeCFGOCZKejLksLdnNQPfSVoZbOyY2mhSjdNFOnFBnkEMgsjZoRw7wH
         MX1u7g4TiG+btgHspYWIL12N1P5slDFrTf7PUgK2QWhtCzkyHeW7ZDtqdcS48gGglzSq
         S4cgXWD9B0D+6BhwZbvyBIr3fj5IpW85b1NKXjDZwutoxcCl0uZoOKFu7EiA/9zAMZCc
         rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElFrXwSwCVPRAW+hNoFiRlLykLfaXSBn/Xpo3VMfLLk=;
        b=xIOQZeyNBaLVHu5B3eiUnBJ83Vk9DUSbk01sO+1s+LoVoifD3ZQ0w5mf2UvWtMQXT6
         VhnwBXul5SmebdH2mcn+G/h0BYFXFRTETIbzRBiLxCbXZGqocdp+Ee+xC7n8YVYA59dQ
         w+oeYDvLdaKA3Fdk4DppBGpluR0A5J7rPxXZ8xKsgzE2w/f+xhvxMDfR/nsLyFfI7D5Z
         Qz4MpsKSNzDf2kM5A7ULSFrzVgTAklBeazPi7abqykGQVnABlLjoaEAMC/ryp1Pjdn3E
         tadjGfspawH74ET/WoxWWkLqTGcKzxJ3+h5Jww2ws5f/mJy0Eizd67ilsz44XbtA1KB1
         U/fg==
X-Gm-Message-State: AJIora+zcxCsj9QaExOVw2GBJS8f3V2+aodDDfO0lAO6Eu7nJRTXXy06
        XDr8AGzg6GkFLQLiNv2MgJz4PQ==
X-Google-Smtp-Source: AGRyM1upVwjgt9V6koh5c+6kvyMccavSbjHn9yi1EVuTbS5UDByI2R5SzZFO798xd+xGxS7lQZCThA==
X-Received: by 2002:a05:6402:d5c:b0:435:6e2f:245b with SMTP id ec28-20020a0564020d5c00b004356e2f245bmr6482479edb.145.1655931453857;
        Wed, 22 Jun 2022 13:57:33 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b00711d88ae162sm9788042ejg.24.2022.06.22.13.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 13:57:33 -0700 (PDT)
Message-ID: <0308c92a-0e10-35a4-928b-8f715a7bae44@linbit.com>
Date:   Wed, 22 Jun 2022 22:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: drbd: drbd_state: Fix typo in comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk
References: <20220622155220.8704-1-jiangjian@cdjrlc.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220622155220.8704-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 22.06.22 um 17:52 schrieb Jiang Jian:
> Replace 'is' with 'it'
> 
> file: drivers/block/drbd/drbd_state.c
> line: 1900
> 
> * But is is still not save to dreference ldev here, since
> 
> changed to:
> 
> * But it is still not save to dreference ldev here, since
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index 3f7bf9f2d874..99927c44f0c3 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -1897,7 +1897,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
>  		int was_io_error = 0;
>  		/* corresponding get_ldev was in _drbd_set_state, to serialize
>  		 * our cleanup here with the transition to D_DISKLESS.
> -		 * But is is still not save to dreference ldev here, since
> +		 * But it is still not save to dreference ldev here, since
>  		 * we might come from an failed Attach before ldev was set. */
>  		if (device->ldev) {
>  			rcu_read_lock();

I agree with James here, I do not think this provides much value.

In fact, the *same* line you are changing contains two more spelling
mistakes ("save" and "dreference").

My opinion is that trivial patches like this are fine as a starting
point for new contributors, which is why I acked the previous patch from
you guys. However, if we start getting two of these every week it just
adds more maintenance burden than it's worth.

So thanks for the contribution, but it's a NAK from me.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
