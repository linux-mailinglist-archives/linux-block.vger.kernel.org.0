Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E352859EA8D
	for <lists+linux-block@lfdr.de>; Tue, 23 Aug 2022 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiHWSH5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Aug 2022 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiHWSHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 14:07:42 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193AF47F7
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 09:16:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b142so11282905iof.10
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=FfGb2wigYjFI5ciFl9OH1jPsygAhh+SORQgeVQ9bFzo=;
        b=gnd+uSIEHxALxFyh8A3GGfp997Qazd+/W0jHV3iRaLnXtBS5dR3S1g/zhFVdtDtpid
         wyVthm35Yf8bGYUMv6e4UKU7/8TuGo/k8TXj4ztio2AbGDkusFZoWpmf5ACsiT8GSSYd
         b8kMuG4Mxq97q1wOoLzDa5IXtQT0Tnen2rw6JLsuMAKrrikw52b8fDvmORwi6IvePNp7
         IJQEUH/eqF04gDUnsWcrD+E7jKqhuNHPPvE6tNEZIn1yHdUZG6Htatnbx3N7PTRiOQh2
         Ov1LPHzZ5JTVbKjolZGE3Q0VgpvvsVsooiLdii+iyVckbgB3EYSWhhuhX9Mhc0wXGzN6
         4TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FfGb2wigYjFI5ciFl9OH1jPsygAhh+SORQgeVQ9bFzo=;
        b=BfVAwL311hyjKguLVKoXA0jvikykHMdQ426ds+tiWXCV/ulc4zRVn4cuxFGSiK5WhP
         98ljBs+OjOwDGjhMlTnBs1Kr6GPeGtAgtCo/LOORM3UObG6K3fXxlgUpoeAQtkpskw99
         sC9owdiDztv6QWyRUXv3cgKE56ycOd7g1yOf1NZsRNZ5VNAve5RjsoduYYuQxO6Y9NPD
         dVdrl4L+5bmLPyv3DDsAI0QOdpN1Zh9QjpGHrN4DzBduIwCRMvpR9zR+W8ay495lxltf
         szGV4D2oExzVlbQMhc7uV7idaIZ+UyoJaakJmnMJG09FEzcJlGhgrof1htsZ6bXSknet
         X06g==
X-Gm-Message-State: ACgBeo3NBpbVc5iwveILLCetUr17X4KH+cmY5zp083A4ogVAoyYUFv+W
        UKvBcytCAa/TVZZcEp6WaliSsuYAtkpPDg==
X-Google-Smtp-Source: AA6agR6uQip3RJlf9k2Cqr7uH0RT3UsbNmo6RMeNckSsbZdah2DIcYdO7CxQK5sE1I190+W0nLbuHA==
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id q3-20020a0566022f0300b006789c7c97a5mr11206025iow.32.1661271407112;
        Tue, 23 Aug 2022 09:16:47 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a4-20020a02a004000000b00349ba0d1137sm4588633jah.24.2022.08.23.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:16:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        hch@infradead.org
In-Reply-To: <20220823160810.181275-1-code@siddh.me>
References: <20220823160810.181275-1-code@siddh.me>
Subject: Re: [PATCH v2] loop: Check for overflow while configuring loop
Message-Id: <166127140632.124225.483036207879834754.b4-ty@kernel.dk>
Date:   Tue, 23 Aug 2022 10:16:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Aug 2022 21:38:10 +0530, Siddh Raman Pant via Linux-kernel-mentees wrote:
> The userspace can configure a loop using an ioctl call, wherein
> a configuration of type loop_config is passed (see lo_ioctl()'s
> case on line 1550 of drivers/block/loop.c). This proceeds to call
> loop_configure() which in turn calls loop_set_status_from_info()
> (see line 1050 of loop.c), passing &config->info which is of type
> loop_info64*. This function then sets the appropriate values, like
> the offset.
> 
> [...]

Applied, thanks!

[1/1] loop: Check for overflow while configuring loop
      commit: f11ebc7347340d291ba032a3872e40d3283fc351

Best regards,
-- 
Jens Axboe


