Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8049C605A01
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJTIfZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJTIfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 04:35:03 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2CB3B736
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 01:34:34 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 20 Oct 2022 16:34:29
 +0800 (GMT+08:00)
X-Originating-IP: [10.190.70.34]
Date:   Thu, 20 Oct 2022 16:34:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: elevator refcount fixes
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <39fa5c8e.13e668.183f4879255.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAn31oWCFFj0qMaBw--.39345W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgEJB1ZdtcA0+gAAs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAKPiB0aGlzIHNlcmllcyBpcyBhIHRha2Ugb24gdGhlIGVsZXZhdG9yIHJlZmNvdW50IGZpeGVz
IGZyb20gSmlubG9uZy4KPiBJJ3ZlIGFkZGVkIGEgY2xlYW51cCBwYXRjaCwgYW5kIG9uZSB0aGF0
IGltcHJvdmVzIG9uIG9uZSBvZiB0aGUgaW5jaWRlbnRhbAo+IGZpeGVzIGhlIGRpZCwgYXMgd2Vs
bCBhcyBzcGxpdHRpbmcgdGhlIG1haW4gcGF0Y2ggaW50byB0d28gYW5kIGltcHJvdmluZwo+IHNv
bWUgY29tbWVudHMuCj4gCgpUaGUgc2VyaWVzIGlzIG11Y2ggY2xlYXJlciB0aGFuIG15IG9yaWdp
bmFsIGxvbmcgcGF0Y2guIFRoYW5rIHlvdSBDaHJpc3RvcGghCgpKaW5sb25nIENoZW4K
