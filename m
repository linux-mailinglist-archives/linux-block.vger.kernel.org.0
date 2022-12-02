Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5A6400BD
	for <lists+linux-block@lfdr.de>; Fri,  2 Dec 2022 07:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiLBG4x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Dec 2022 01:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiLBG4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 01:56:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29418BC5AD;
        Thu,  1 Dec 2022 22:56:50 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F17F21B5C;
        Fri,  2 Dec 2022 06:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669964208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKRlnmSi9cULYBX+c6mBT5MzyG+E0j7vwb/2t12kBrw=;
        b=c2Xb0pewOZr4hWEphekzh/H9MizOIOT4EFBfJ4UojhvnX/ethC1ngZup0oFLVYV89dGND9
        H/GOWzLrqXOa4gUpwZNpqavAyYT2Zj1vHy4RCk5iFd2jCtcbDMOxU60W1WohBj/MhYi/G1
        XJyEbKd37QaChm4BtqOuxFhrEKVkXeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669964208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKRlnmSi9cULYBX+c6mBT5MzyG+E0j7vwb/2t12kBrw=;
        b=jxG49tsMXLSVVWmmTavuLSz586smJ3JQ/2DDpzYt7da2V+CxS9FrMs6kUumBXuKl40YHpj
        x/FX5AAocE1QlfAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 689C3133DE;
        Fri,  2 Dec 2022 06:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vMRwGLChiWOTeAAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 02 Dec 2022 06:56:48 +0000
Message-ID: <4a3b6a0f-be1b-e0b1-941b-6701a42e9a2c@suse.de>
Date:   Fri, 2 Dec 2022 07:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/3] block: sed-opal: keyring support for SED keys
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        keyrings@vger.kernel.org
References: <20221129232506.3735672-1-gjoyce@linux.vnet.ibm.com>
 <20221129232506.3735672-4-gjoyce@linux.vnet.ibm.com>
 <c78edd60-b6ae-6ec0-9ce4-73b9a92b9b32@suse.de>
 <ed32cbc546383085bc8c00d913a53059831b2cfc.camel@linux.vnet.ibm.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ed32cbc546383085bc8c00d913a53059831b2cfc.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/22 19:03, Greg Joyce wrote:
> On Wed, 2022-11-30 at 08:00 +0100, Hannes Reinecke wrote:
>> On 11/30/22 00:25, gjoyce@linux.vnet.ibm.com wrote:
>>> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>>>
>>> Extend the SED block driver so it can alternatively
>>> obtain a key from a sed-opal kernel keyring. The SED
>>> ioctls will indicate the source of the key, either
>>> directly in the ioctl data or from the keyring.
>>>
>>> This allows the use of SED commands in scripts such as
>>> udev scripts so that drives may be automatically unlocked
>>> as they become available.
>>>
>>> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>>> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
>>> ---
>>>    block/Kconfig                 |   1 +
>>>    block/sed-opal.c              | 174
>>> +++++++++++++++++++++++++++++++++-
>>>    include/linux/sed-opal.h      |   3 +
>>>    include/uapi/linux/sed-opal.h |   8 +-
>>>    4 files changed, 183 insertions(+), 3 deletions(-)
>>>   
>>> +	ret = opal_get_key(dev, &opal_lrs->session.opal_key);
>>> +	if (ret)
>>> +		return ret;
>>>    	mutex_lock(&dev->dev_lock);
>>>    	setup_opal_dev(dev);
>>>    	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
>>> @@ -2622,6 +2759,14 @@ static int opal_set_new_pw(struct opal_dev
>>> *dev, struct opal_new_pw *opal_pw)
>>>    	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
>>>    	mutex_unlock(&dev->dev_lock);
>>>    
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* update keyring with new password */
>>> +	ret = update_sed_opal_key(OPAL_AUTH_KEY,
>>> +				  opal_pw->new_user_pw.opal_key.key,
>>> +				  opal_pw-
>>>> new_user_pw.opal_key.key_len);
>>> +
>>>    	return ret;
>>>    }
>>>    
>> What about key revocation?
>> You only allow to set a new key, but what happens with the old ones?
> 
> My understanding was that key_create_or_update() would not allow
> duplicates so there shouldn't be old ones. Is that incorrect?
> 
Ah, right, you only have one key.
But still, you might want to revoke that one, too, no?
(Think of decommissioning old drives ...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

