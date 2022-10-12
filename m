Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA75FCA0F
	for <lists+linux-block@lfdr.de>; Wed, 12 Oct 2022 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJLRuT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Oct 2022 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLRuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 13:50:19 -0400
X-Greylist: delayed 1804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 10:50:16 PDT
Received: from zuombrgn.myspeace.com (zuombrgn.myspeace.com [45.95.169.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D36C95A
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=myspeace.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=jan.cha@myspeace.com;
 bh=5veHaSCo0CbAZntugzt28BVHSVA=;
 b=GJJ8sh3Tf+62qkd9M93nXOeLmmDu/LlIDGHOZ+8v89TibzMQckmOCgD7H28D6IAC73axR5GFRtbw
   dWmMJG7aoPZ3SJ0Wo76oJekh7ApB40ftObIIFC42cRSxGhYvWlFyE+0xSPrpNg8tzhFsonW4u9ol
   Mu1azhGobBVmsxckwxvDoSaJNsT2NJZ49XLqvVJfNqoqP/iya9butGxmKxBNTppkYv5pBMZ0sBO6
   uQKvdUcsL0T65RDFwevPP1kkXvfH0eAUlBQmeqtQfB6cJMeYmC1yhfYtJuSgMsJWInsosyMbkdb2
   F9NTXYg+I9BmwZ6em3tv5Au2K549bD7QTxAUmw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=myspeace.com;
 b=tXhtiO8u3aKtsd9deeQ7J0/R2j1n3+V7aLYg1rauXNJxemZU672k+0YTiGm5hX7to8hUUL1oYWRQ
   c67bp5tK1/vtMoIvCYDFW5jK09/3yXxxG2waDdTbkqI8qlQUt1U+jI8kxMbmTDS/qpA1mSds9fgI
   Sj2s3dKqPZOwChLnX7C/myQm55t2mmguER32tz/nJqnPZHFxeK10fnOLnCJo7mjWewkxiE7cmWPl
   /3l9vC4DR0cEC8hY4hxXrlm3qRy9K0oO3RtqabxT/k0isqomSisD+YVno1LwDi2ECnlQfIxXF6Ew
   EdR2F+RxJFXbz3Wgj1Vu0zEcRBCP+xO8WwZd2Q==;
Reply-To: m.ayvaz@mayvazburosu.com
From:   Mustafa Ayvaz <jan.cha@myspeace.com>
To:     linux-block@vger.kernel.org
Subject: linux-block
Date:   12 Oct 2022 19:20:09 +0200
Message-ID: <20221012192009.CCFBCE79B7553064@myspeace.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOCALPART_IN_SUBJECT,
        RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: myspeace.com]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?45.95.169.87>]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8144]
        *  1.1 LOCALPART_IN_SUBJECT Local part of To: address appears in
        *      Subject
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Good day,

I was only wondering if you got my previous message? I have been=20
trying to reach you on your email: linux-block@vger.kernel.org ,=20
I want to share a business opportunity with you. kindly get back=20
to me swiftly,  it is very important.

Thanks
Mustafa Ayvaz
