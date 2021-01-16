Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD32F8D13
	for <lists+linux-block@lfdr.de>; Sat, 16 Jan 2021 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAPLGx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 Jan 2021 06:06:53 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:13292 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbhAPLGx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 06:06:53 -0500
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 16 Jan 2021 19:05:46
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sat, 16 Jan 2021 19:05:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>
Cc:     "kjlu@umn.edu" <kjlu@umn.edu>, "Jens Axboe" <axboe@kernel.dk>,
        "Hannes Reinecke" <hare@suse.de>, "Jan Kara" <jack@suse.cz>,
        "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>,
        "Ming Lei" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] block: Fix an error handling in add_partition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <BYAPR04MB4965E41A9C690FA11883469A86A60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210116072802.21940-1-dinghao.liu@zju.edu.cn>
 <BYAPR04MB4965E41A9C690FA11883469A86A60@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <767024ca.436d9.1770adf5c69.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXfICKyAJgHFZ_AA--.24129W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMHBlZdtSAnLAABsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBPbiAxLzE1LzIxIDExOjM0IFBNLCBEaW5naGFvIExpdSB3cm90ZToKPiA+IE9uY2Ugd2UgaGF2
ZSBjYWxsZWQgZGV2aWNlX2luaXRpYWxpemUoKSwgd2Ugc2hvdWxkCj4gPiB1c2UgcHV0X2Rldmlj
ZSgpIHRvIGdpdmUgdXAgdGhlIHJlZmVyZW5jZSBvbiBlcnJvciwKPiA+IGp1c3QgbGlrZSB3aGF0
IHdlIGhhdmUgZG9uZSBvbiBmYWlsdXJlIG9mIGRldmljZV9hZGQoKS4KPiA+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiBQbGVhc2UgY29u
c2lkZXIgaGF2aW5nIGZvbGxvd2luZyBjb21taXQgbWVzc2FnZSwgc2luY2UgYWJvdmUKPiBjb21t
aXQgbWVzc2FnZSBpcyBsb29raW5nIG9kZCBmcm9tIHdoYXQgd2UgaGF2ZSBpbiB0aGUgdHJlZSA6
LQo+IAo+IAo+IE9uY2Ugd2UgaGF2ZSBjYWxsZWQgZGV2aWNlX2luaXRpYWxpemUoKSwgd2Ugc2hv
dWxkIHVzZSBwdXRfZGV2aWNlKCkgdG8KPiBnaXZlIHVwIHRoZSByZWZlcmVuY2Ugb24gZXJyb3Is
IGp1c3QgbGlrZSB3aGF0IHdlIGhhdmUgZG9uZSBvbiBmYWlsdXJlCj4gb2YgZGV2aWNlX2FkZCgp
Lgo+IAoKVGhhbmtzIGZvciB0aGlzIHN1Z2dlc3Rpb24hCiAKPiAKPiBBbHNvIGhhdmUgeW91IHRl
c3RlZCB0aGlzIHBhdGNoIHdpdGggdGhlIHdpdGggZ2VuZXJhdGluZyBhcHByb3ByaWF0ZSBlcnJv
ciA/Cj4gCgpObywgdGhpcyBwcm9ibGVtIGlzIGZvdW5kIHRocm91Z2ggY29tcGFyaW5nIGV4aXN0
aW5nIHNvdXJjZSBjb2RlLiAKClJlZ2FyZHMsCkRpbmdoYW8=
