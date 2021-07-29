Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54763D9C00
	for <lists+linux-block@lfdr.de>; Thu, 29 Jul 2021 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhG2DJV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 23:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhG2DJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 23:09:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE6C0613C1
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 20:09:18 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o13so4511023qkk.9
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=SdHnd3UxhQxILD5sIY68I8w2CS+2K2nQR0hdwBItcSQ=;
        b=1fuWuTp0S9vFfzdBLCV3w1xBUH4RYC//+UhbZLlGYzInl7HpKECRExfamgdx9eRolN
         pXxGhX4yl1vQgiqq79cpBOenFVyx6uEYvqYz2oqAhPuX1kIcBreKvpIlI0irOSjtsjXU
         0W6X8Mas7FaprAPVqoVjugg9OX0tHpHbPSRCqMOTMc7NwRWFNP6Po371r05TndavoxN3
         7ZOQNrGPvcO+rXPj+GuqhhCfqOQOOxOFjXEvQpB9G5bbJRXCq/6PQEAN5AnFSjrLQ+9e
         d6lJcFOP0YVNlrp6ii47qjLM0W97tovZ/w2mTmrNJxiMCrEjlo6pv5Usv83bGYFxyMCa
         1p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=SdHnd3UxhQxILD5sIY68I8w2CS+2K2nQR0hdwBItcSQ=;
        b=ezigpwXARcIt2kXXMgJ0SDh/fN+RoDsDn20VM4yZNVrYkN1WS1gVdZ1zh32GnVETSE
         E/umffAHV7/GAbbTMmfFTF32+/pB/GVo4jDzZPyNhnBG6ajNfV72kXE7DV7mFjtjhDUc
         mh6YVdONJMe0HlqwqdlYhPPWdoit4ITVqaB4/IrN318ucKi5fwN3T50IolfaIIqYl6mi
         MSkewPXVgksuWy0Vh5K/yqA02yoyhKD/rhD0eJAQ9iIfiekrDsxYZQyX3pqGwp1wCbCJ
         txBMH5dWGsa8ysXASg9LrL0jQbFkPYoxhyzaZl57sK3OGgsRxRM8Ckys1++ShLBvgSq/
         J88Q==
X-Gm-Message-State: AOAM533Ekqs+E8p32WrEIMqJ93Y7EMcMb2a2gvbEKJafbCohjLtAl2St
        fYSacFW2Vnvdf6Z4vVS1JXtybQ==
X-Google-Smtp-Source: ABdhPJwDK0qVuMlp6WgaA3Az4Au4QJilqAUMO8ICEJgVOV83q4gFst/vTmoNWJBscKKsVOjnSF/VOA==
X-Received: by 2002:a37:6151:: with SMTP id v78mr3152537qkb.9.1627528157390;
        Wed, 28 Jul 2021 20:09:17 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id q11sm1011870qkm.56.2021.07.28.20.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:09:16 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org,
        axboe@kernel.dk, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [RFC PATCH 1/8] docs: Add block device LED trigger documentation
In-Reply-To: <20210729015344.3366750-2-arequipeno@gmail.com>
References: <20210729015344.3366750-1-arequipeno@gmail.com>
 <20210729015344.3366750-2-arequipeno@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1627528155_13589P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Jul 2021 23:09:15 -0400
Message-ID: <108629.1627528155@turing-police>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--==_Exmh_1627528155_13589P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Jul 2021 20:53:37 -0500, Ian Pilcher said:

> +Create a new block device LED trigger::
> +
> +	# echo foo > /sys/class/block/led_trigger_new
> +
> +The name must be unique among all LED triggers (not just block device LED
> +triggers).
> +
> +Create two more::
> +
> +	# echo bar baz > /sys/class/block/led_trigger_new

> +	# cat /sys/class/block/led_trigger_list
> +	baz: 0
> +	bar: 0
> +	foo: 0

This looks like an abuse of the "one entry one value" rule for sysfs.
Perhaps this should be a directory /sys/class/block/defined_triggers/
and separate files under that for foo, bar, and baz?  That would probably
make reference counting a lot easier as well....

--==_Exmh_1627528155_13589P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhAhvbAAoJEI0DS38y7CIctZEH/3Pdfz1JB35y9wFELHDki00R
/UC64FJqOqMfASDl0QtxgVV1S3MfGAAqXFlUw1Djb/0/ZcytyZ22f2S0u8JaP9Qx
M4Wr0eo5A/BLR7csFwxoxN7lfxDFyEcsKKx+kkZZgfmoqbTLzt46NXTRWrcxJ5p4
rc9KA6hWGz3GYFUj48Maz9VA3hNz3RLcmOy/F1DKHk7nwBrXZ775iKToao4uNNrw
Y0NNAAFQYQ8LBZkf5G2hxBakpIA5jY+7arv2dIDO6f+MyDQYKH8gvJEO1vFmiyMM
OAufuI4mM8ouhA11rIRqtZZ9acl12CJt/OK8FPifF+ypiFVqbqZHteNbzIvbmY4=
=IjcV
-----END PGP SIGNATURE-----

--==_Exmh_1627528155_13589P--
