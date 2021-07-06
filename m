Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4C3BC4EF
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 04:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGFC5F (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Jul 2021 22:57:05 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:26988 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhGFC5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 22:57:05 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 22:57:04 EDT
DKIM-Signature: a=rsa-sha256;
        b=bwodXl/XnhU0wPZNZRW5HpfN7xYtE7Bo59sLyLCA1iYSSvfXo9EM35QTkkaajxe9fZv9rcU4hS9L3lI/fEFe+1pCtqLOHg3ww2uyN5z2ZI/0jnGy8iRPPuwLegVN3pUNwxsRB20uFuEAZ9UdLL4PvsDbeFbfR03oWmRpOr6Bdb4=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=KrYjTwf7UCi1FnHY5Gd7bUkuDbkut/mEO8upxNqtuXI=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id 76B276C00E2;
        Tue,  6 Jul 2021 10:48:38 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACIApACiD5wc1jenFSSg*4pr.3.1625539718472.Hmail.wangqing@vivo.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYmxvY2s6IG5iZDogZml4IG9yZGVyIG9mIGNsZWFuaW5nIHVwIHRoZSBxdWV1ZSBhbmQgZnJlZWluZyB0aGUgdGFnc2V0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <d32f0c7c-4cbc-d754-817b-1c3f58a3e776@linux.dev>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 6 Jul 2021 10:48:38 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Tue, 6 Jul 2021 10:48:38 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR9JT1YYQhlOGktMSxlOHRpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PQ0JDSk1JTU5LN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6ODI6Czo4Ej9ODBhKER4VPSgoHFFPCwlVSFVKTUlOTkhCTEpDTExIVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOQ1lXWQgBWUFISk9INwY+
X-HM-Tid: 0a7a79b7ad5bd9a9kuws76b276c00e2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cj4KPk9uIDcvNS8yMSA1OjI1IFBNLCBXYW5nIFFpbmcgd3JvdGU6Cj4+IE11c3QgcmVsZWFzZSB0
aGUgcXVldWUgYmVmb3JlIGZyZWVpbmcgdGhlIHRhZ3NldC4KPj4KPj4gRml4ZXM6IDFjOTk1MDJm
YWUzNSAoImxvb3A6IHVzZSBibGtfbXFfYWxsb2NfZGlzayBhbmQgYmxrX2NsZWFudXBfZGlzayIp
Cj4+IFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IHN5emJvdCs5Y2E0M2ZmNDcxNjdjMGVlMzQ2NkBz
eXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4KPkRpZCBzeXpib3QgYWN0dWFsbHkgdGVzdCB0aGUg
Y2hhbmdlPwoKWWVzLCBJIGhhdmUgaW5pdGlhdGVkIHRoZSB0ZXN0LCBhbmQgZGlkIG5vdCByZXBv
cnQgdGhpcyBlcnJvciBhZ2FpbiwgYnV0IHN0aWxsIHJlcG9ydGVkIG90aGVyIGtub3duIGVycm9y
cywKc28gSSB0aGluayB0aGUgdGVzdCBwYXNzZWQuIEFuZCB0aGlzIGlzIGFuIG9idmlvdXMgcHJv
YmxlbSwgaXQgbmVlZHMgdG8gYmUgZml4ZWQgYW55d2F5LgoKPgo+PiBTaWduZWQtb2ZmLWJ5OiBX
YW5nIFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEpp
YW5nIDxndW9xaW5nLmppYW5nQGNsb3VkLmlvbm9zLmNvbT4KPgo+SSBkb24ndCBtaW5kIHlvdSBz
ZW50IGl0IHF1aWNrbHksIGJ1dCBwbHMgcmVtb3ZlIG15IG91dGRhdGVkIG1haWwgYWNjb3VudC4K
ClNvcnJ5IGFib3V0IHRoaXMsIHlvdSBjYW4gcmUtaW5pdGlhdGUgYSBwYXRjaCBpZiB5b3UgZG9u
J3QgbWluZCwgCmFzIGlmIHlvdSBzdGlsbCBoYXZlIG9uZSB0aGluZyB0byBtb2RpZnkuCgpRaW5n
Cj4KPkd1b3FpbmcKDQoNCg==
