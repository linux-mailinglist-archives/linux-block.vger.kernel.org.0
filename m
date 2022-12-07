Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB83645510
	for <lists+linux-block@lfdr.de>; Wed,  7 Dec 2022 09:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLGIGA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Dec 2022 03:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLGIF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 03:05:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF0286D7
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 00:05:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h10so17363157wrx.3
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 00:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u1TY977SO93+OAaYVy2K9hxO04GJrqmIBKKKnptva3U=;
        b=O0v0q1ehTwMkl06PIuonjtt48bOvZ8RshSlMHTTEqyz+hdeFBWoShPzNnkUCv71aqM
         jd1BU9S1LaWjq/H9rvwxGUjn9colllDJ85imqle0G5bIOkiJ+jYZ2AeImWQNDUW1mQOH
         zK0cPdLqz/UqcpoVYkJMvLgSPjqUUPtf53sIxzPnyvLLcZMo3Bf9AxMW9fCMv9F5+HOt
         Ze+q8bYGhxBMf+zYy0j1y6HLDUxpjjnoYdpYnypuQvT6SJ3yt6VXdq/0pxzrwmQ+n0sG
         z9wEKgEzpuEMe9POoiulNw6goAxj8XEiXCcuWDsq6viJKFLI58TeMKucGvLeqDYuRgVL
         vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1TY977SO93+OAaYVy2K9hxO04GJrqmIBKKKnptva3U=;
        b=ojljb+aHSOb5x+jzu3Jo+euLdzJdkqQPZF1stqhomVkSHhbiM/48CW6JOapMN0oFs9
         CWMe7cnAhWk4HjIL7RD5ztIt0uEjH0SrvT3XOWh+ERO/nrlBskGXQRxCyRjG2Xv+2cz0
         1bNaNPGQhvOsOkR74/Gc/Uo2feXFCGfkZqVCRHVIIFft2qqygFO74Qt8idZemATsZ3zu
         c4wzd5N4qiB14qLE3L6lATFwwhgbaUU+CoPxSGQmBUR2N9xQD0Ie+kmU3W8uoPCEaZVJ
         EWzbiXBR/JsacaOp3yvF61SrncpaqbnBMgn8ZUBgJrIacaIt6HOrjq/auPnL4ozFN45V
         Jvgg==
X-Gm-Message-State: ANoB5pliLeSLWJhJWsjDXODZ2jPsapz+fGv7FjatFYHjqKodmZ6t2VnI
        7ftuqaSZEYYgvs+RNxVv3/dyxOsC077w6lQhC4fU45pRMcEZ1Q==
X-Google-Smtp-Source: AA0mqf7gdiKQZ+LFIiO70qmSt06Q2Up7L5s4GJHJSSBWxoJ1jwp6qgNmLrwHHph8N0sTGEtvPPdKLHqyghE0dXdgGAc=
X-Received: by 2002:adf:f789:0:b0:242:129b:9cb9 with SMTP id
 q9-20020adff789000000b00242129b9cb9mr23415466wrp.373.1670400357330; Wed, 07
 Dec 2022 00:05:57 -0800 (PST)
MIME-Version: 1.0
From:   Leon Schmidt <leonjohannesschmidt@gmail.com>
Date:   Wed, 7 Dec 2022 09:05:46 +0100
Message-ID: <CAO+mVXZJ4xbpjizp8EAbFAezzdjMMuje-SM1DjN5NNnT5g63cQ@mail.gmail.com>
Subject: 
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

      auth cc0072fd subscribe linux-block leonjohannesschmidt@gmail.com
