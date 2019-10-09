Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B4D0D9B
	for <lists+linux-block@lfdr.de>; Wed,  9 Oct 2019 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJIL1u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Oct 2019 07:27:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIL1t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Oct 2019 07:27:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so1218146pgl.7
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2019 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WopUBO6/gb73qbJqvCFm1PZQMljoqG9UlzGJ/1LfsZA=;
        b=lwNjAVuZG4ajbsnZgSwMREMd1LjzLzgqi8ABbn7MctPp1fPStwKvT5YHMqKt53Znb5
         yQWdqWb1qaAGcqHGqVNOusVfnzuK23yegYAGHCGa8zTwjaMrw+LxeMIS8ZF2HoMhIsfC
         02pI89voFoKKQ3QU6i8NmMbD323YRzAAp3I33QmYjY4fYNc2Z6+1ZKJPh7Xd2pm8I5d1
         XmA3CpgyCkcPYRZnAhSQAzKOqxfRAMxdr+3LXKwc7m5i/AVi/BhOFl3AvOjuFK33vUiu
         e4ZliUtjaP1qKXqycV2kz9lc38WFaVcXud7bbfXRxEFuzoy5lMEaxpIjNIt4509jjhaX
         tmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WopUBO6/gb73qbJqvCFm1PZQMljoqG9UlzGJ/1LfsZA=;
        b=ikfv7T6rWTJ9rF5CdNW+CN7voqLt29zttH+Htvsd03rufITk8s4bAocoOtEUs3zqnR
         Q0wobneTQQACUQvcWSLIr/5PE0vUbrsqF3p9TrIja2qDtrsd4pXu6NplZsaEyDnmFWKf
         hhg2O5wSfEvNgNA/2MS+1tHKVw0b258/kvGdiz5cGhD5P7Q8Pap0Drbkt+3nTL7q1yh4
         xdm3tgduTrI+V1bV5iYIOPJHLqELWAFl5di37fyY4bHod8xZJqYsuFouTa4L+KVrq7Wz
         AegBbW0BveYIKJ0aXGzij+hUwqb82HTs4mCnAevUAdSo3JgwKO6z7Pv4ELSZ54eE6BZo
         uSMA==
X-Gm-Message-State: APjAAAWaYxMpCUV5hIUFzvT4OG6SKAA52eADcCVd1vtm2fkQxyOLnEiB
        Tq8xNA3QPBcDf8xA5rVj5Hcp+yYBiqUngQ==
X-Google-Smtp-Source: APXvYqyhKTReJDCAlEAc/Bdyi238CJ6SDFOGhMcopn/82h62n4LmhiyfAYDrTz2ymsvpF2rhOIU5RA==
X-Received: by 2002:a17:90a:bf09:: with SMTP id c9mr2795023pjs.9.1570620466792;
        Wed, 09 Oct 2019 04:27:46 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y138sm2813508pfb.174.2019.10.09.04.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 04:27:45 -0700 (PDT)
Subject: Re: io_uring NULL pointer dereference on Linux v5.4-rc1
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191009092302.GA5303@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9beeedf-3a06-841f-53a4-51ac4e9e13ea@kernel.dk>
Date:   Wed, 9 Oct 2019 05:27:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009092302.GA5303@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvOS8xOSAzOjIzIEFNLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6DQo+IEkgaGl0IHRo
aXMgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4gcnVubmluZyBxZW11LWlvdGVzdHMg
MDUyIChyYXcpDQo+IG9uIGJvdGggZXh0NCBhbmQgWEZTIG9uIGRtLXRoaW4vbHVrcy4gIFRo
ZSBrZXJuZWwgaXMgTGludXggdjUuNC1yYzEgYnV0DQo+IEkgaGF2ZW4ndCBmb3VuZCBhbnkg
b2J2aW91cyBmaXhlcyBpbiBKZW5zJyB0cmVlLCBzbyBpdCdzIGxpa2VseSB0aGF0DQo+IHRo
aXMgYnVnIGlzIHN0aWxsIHByZXNlbnQ6DQo+IA0KPiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAxMDINCj4gI1BGOiBzdXBl
cnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ICNQRjogZXJyb3JfY29kZSgw
eDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiBQR0QgMCBQNEQgMA0KPiBPb3BzOiAwMDAw
IFsjMV0gU01QIFBUSQ0KPiBDUFU6IDIgUElEOiA2NjU2IENvbW06IHFlbXUtaW8gTm90IHRh
aW50ZWQgNS40LjAtcmMxICMxDQo+IEhhcmR3YXJlIG5hbWU6IExFTk9WTyAyMEJUUzFONzBW
LzIwQlRTMU43MFYsIEJJT1MgTjE0RVQzN1cgKDEuMTUgKSAwOS8wNi8yMDE2DQo+IFJJUDog
MDAxMDpfX3F1ZXVlX3dvcmsrMHgxZi8weDNiMA0KPiBDb2RlOiBlYiBkZiA2NiAwZiAxZiA4
NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0NCAwMCAwMCA0MSA1NyA0OSA4OSBmNyA0MSA1NiA0
MSA4OSBmZSA0MSA1NSA0MSA4OSBmZCA0MSA1NCA1NSA0OCA4OSBkNSA1MyA0OCA4MyBlYyAx
MCA8ZjY+IDg2IDAyIDAxIDAwIDAwIDAxIDBmIDg1IGJjIDAyIDAwIDAwIDQ5IGJjIGViIDgz
IGI1IDgwIDQ2IDg2IGM4DQo+IFJTUDogMDAxODpmZmZmYmVmNDg4NGJiZDU4IEVGTEFHUzog
MDAwMTAwODINCj4gUkFYOiAwMDAwMDAwMDAwMDAwMjQ2IFJCWDogMDAwMDAwMDAwMDAwMDI0
NiBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gUkRYOiBmZmZmOTkwMzkwMWY0NDYwIFJTSTog
MDAwMDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwNDANCj4gUkJQOiBmZmZmOTkw
MzkwMWY0NDYwIFIwODogZmZmZjk5MDM5MDFmYjA0MCBSMDk6IGZmZmY5OTAzOTg2MTQ3MDAN
Cj4gUjEwOiAwMDAwMDAwMDAwMDAwMDMwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAw
MDAwMDAwMDAwMDAwMDANCj4gUjEzOiAwMDAwMDAwMDAwMDAwMDQwIFIxNDogMDAwMDAwMDAw
MDAwMDA0MCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCj4gRlM6ICAwMDAwN2Y3ZDJhNGU0YTgw
KDAwMDApIEdTOmZmZmY5OTAzYTVhODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAw
MA0KPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
DQo+IENSMjogMDAwMDAwMDAwMDAwMDEwMiBDUjM6IDAwMDAwMDAyMDNkYTgwMDQgQ1I0OiAw
MDAwMDAwMDAwMzYwNmUwDQo+IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAw
MDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IERSMzogMDAwMDAwMDAwMDAwMDAw
MCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IENhbGwg
VHJhY2U6DQo+ICAgPyBfX2lvX3F1ZXVlX3NxZSsweGExLzB4MjAwDQo+ICAgcXVldWVfd29y
a19vbisweDM2LzB4NDANCj4gICBfX2lvX3F1ZXVlX3NxZSsweDE2ZS8weDIwMA0KPiAgIGlv
X3Jpbmdfc3VibWl0KzB4ZDIvMHgyMzANCj4gICA/IHBlcmNwdV9yZWZfcmVzdXJyZWN0KzB4
NDYvMHg3MA0KPiAgID8gX19pb191cmluZ19yZWdpc3RlcisweDIwNy8weGEzMA0KPiAgID8g
X19zY2hlZHVsZSsweDI4Ni8weDcwMA0KPiAgIF9feDY0X3N5c19pb191cmluZ19lbnRlcisw
eDFhMy8weDI4MA0KPiAgID8gX194NjRfc3lzX2lvX3VyaW5nX3JlZ2lzdGVyKzB4NjQvMHhi
MA0KPiAgIGRvX3N5c2NhbGxfNjQrMHg1Yi8weDE4MA0KPiAgIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4gUklQOiAwMDMzOjB4N2Y3ZDM0MzlmMWZkDQo+
IENvZGU6IDAwIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDkwIGYzIDBmIDFl
IGZhIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5
IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMg
NDggOGIgMGQgNWIgOGMgMGMgMDAgZjcgZDggNjQgODkgMDEgNDgNCj4gUlNQOiAwMDJiOjAw
MDA3ZjdkMjkxOGQ0MDggRUZMQUdTOiAwMDAwMDIxNiBPUklHX1JBWDogMDAwMDAwMDAwMDAw
MDFhYQ0KPiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2Y3ZDI5MThkNGYwIFJD
WDogMDAwMDdmN2QzNDM5ZjFmZA0KPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAw
MDAwMDAwMDAwMDAxIFJESTogMDAwMDAwMDAwMDAwMDAwYQ0KPiBSQlA6IDAwMDAwMDAwMDAw
MDAwMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwOA0KPiBS
MTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjE2IFIxMjogMDAwMDU2
MTZlM2MzMmFiOA0KPiBSMTM6IDAwMDA1NjE2ZTNjMzJiNzggUjE0OiAwMDAwNTYxNmUzYzMy
YWIwIFIxNTogMDAwMDAwMDAwMDAwMDAwMQ0KPiBNb2R1bGVzIGxpbmtlZCBpbjogZnVzZSBj
Y20geHRfQ0hFQ0tTVU0geHRfTUFTUVVFUkFERSB0dW4gYnJpZGdlIHN0cCBsbGMgbmZfY29u
bnRyYWNrX25ldGJpb3NfbnMgbmZfY29ubnRyYWNrX2Jyb2FkY2FzdCB4dF9DVCBpcDZ0X3Jw
ZmlsdGVyIGlwNnRfUkVKRUNUIG5mX3JlamVjdF9pcHY2IGlwdF9SRUpFQ1QgbmZfcmVqZWN0
X2lwdjQgeHRfY29ubnRyYWNrIGVidGFibGVfbmF0IGlwNnRhYmxlX25hdCBpcDZ0YWJsZV9t
YW5nbGUgaXA2dGFibGVfcmF3IGlwNnRhYmxlX3NlY3VyaXR5IGlwdGFibGVfbmF0IG5mX25h
dCBpcHRhYmxlX21hbmdsZSBpcHRhYmxlX3JhdyBpcHRhYmxlX3NlY3VyaXR5IG5mX2Nvbm50
cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBpcF9zZXQgbmZuZXRsaW5rIGVi
dGFibGVfZmlsdGVyIGVidGFibGVzIGlwNnRhYmxlX2ZpbHRlciBpcDZfdGFibGVzIGlwdGFi
bGVfZmlsdGVyIGlwX3RhYmxlcyBzdW5ycGMgdmZhdCBmYXQgaW50ZWxfcmFwbF9tc3Igcm1p
X3NtYnVzIGl3bG12bSBybWlfY29yZSBpbnRlbF9yYXBsX2NvbW1vbiB4ODZfcGtnX3RlbXBf
dGhlcm1hbCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1wIG1hYzgwMjExIHNuZF9oZGFfY29k
ZWNfcmVhbHRlayBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgc25kX2hkYV9jb2RlY19oZG1pIGt2
bV9pbnRlbCBzbmRfaGRhX2ludGVsIGt2bSBzbmRfaW50ZWxfbmhsdCBzbmRfaGRhX2NvZGVj
IHNuZF91c2JfYXVkaW8gaXJxYnlwYXNzIHV2Y3ZpZGVvIHNuZF9oZGFfY29yZSBzbmRfdXNi
bWlkaV9saWIgc25kX3Jhd21pZGkgaVRDT193ZHQgc25kX2h3ZGVwIGxpYmFyYzQgaW50ZWxf
Y3N0YXRlIGNkY19ldGhlciBpbnRlbF91bmNvcmUgdmlkZW9idWYyX3ZtYWxsb2MgaXdsd2lm
aSBtZWlfd2R0IG1laV9oZGNwIGlUQ09fdmVuZG9yX3N1cHBvcnQgc25kX3NlcSB2aWRlb2J1
ZjJfbWVtb3BzIHVzYm5ldCB2aWRlb2J1ZjJfdjRsMiBzbmRfc2VxX2RldmljZQ0KPiAgIGlu
dGVsX3JhcGxfcGVyZiBwY3Nwa3IgdmlkZW9idWYyX2NvbW1vbiBqb3lkZXYgd21pX2Jtb2Yg
c25kX3BjbSBjZmc4MDIxMSByODE1MiB2aWRlb2RldiBpbnRlbF9wY2hfdGhlcm1hbCBpMmNf
aTgwMSBtaWkgbWMgdGhpbmtwYWRfYWNwaSBzbmRfdGltZXIgbWVpX21lIGxlZHRyaWdfYXVk
aW8gc25kIGxwY19pY2ggbWVpIHNvdW5kY29yZSByZmtpbGwgYmluZm10X21pc2MgeGZzIGRt
X3RoaW5fcG9vbCBkbV9wZXJzaXN0ZW50X2RhdGEgZG1fYmlvX3ByaXNvbiBsaWJjcmMzMmMg
ZG1fY3J5cHQgaTkxNSBpMmNfYWxnb19iaXQgZHJtX2ttc19oZWxwZXIgZHJtIGNyY3QxMGRp
Zl9wY2xtdWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRlbCBnaGFzaF9jbG11bG5pX2ludGVs
IHNlcmlvX3JhdyB3bWkgdmlkZW8NCj4gQ1IyOiAwMDAwMDAwMDAwMDAwMTAyDQo+IC0tLVsg
ZW5kIHRyYWNlIDJhYzc0N2FjYWJlMjE4ZGEgXS0tLQ0KPiBSSVA6IDAwMTA6X19xdWV1ZV93
b3JrKzB4MWYvMHgzYjANCj4gQ29kZTogZWIgZGYgNjYgMGYgMWYgODQgMDAgMDAgMDAgMDAg
MDAgMGYgMWYgNDQgMDAgMDAgNDEgNTcgNDkgODkgZjcgNDEgNTYgNDEgODkgZmUgNDEgNTUg
NDEgODkgZmQgNDEgNTQgNTUgNDggODkgZDUgNTMgNDggODMgZWMgMTAgPGY2PiA4NiAwMiAw
MSAwMCAwMCAwMSAwZiA4NSBiYyAwMiAwMCAwMCA0OSBiYyBlYiA4MyBiNSA4MCA0NiA4NiBj
OA0KPiBSU1A6IDAwMTg6ZmZmZmJlZjQ4ODRiYmQ1OCBFRkxBR1M6IDAwMDEwMDgyDQo+IFJB
WDogMDAwMDAwMDAwMDAwMDI0NiBSQlg6IDAwMDAwMDAwMDAwMDAyNDYgUkNYOiAwMDAwMDAw
MDAwMDAwMDAwDQo+IFJEWDogZmZmZjk5MDM5MDFmNDQ2MCBSU0k6IDAwMDAwMDAwMDAwMDAw
MDAgUkRJOiAwMDAwMDAwMDAwMDAwMDQwDQo+IFJCUDogZmZmZjk5MDM5MDFmNDQ2MCBSMDg6
IGZmZmY5OTAzOTAxZmIwNDAgUjA5OiBmZmZmOTkwMzk4NjE0NzAwDQo+IFIxMDogMDAwMDAw
MDAwMDAwMDAzMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IFIxMzogMDAwMDAwMDAwMDAwMDA0MCBSMTQ6IDAwMDAwMDAwMDAwMDAwNDAgUjE1OiAw
MDAwMDAwMDAwMDAwMDAwDQo+IEZTOiAgMDAwMDdmN2QyYTRlNGE4MCgwMDAwKSBHUzpmZmZm
OTkwM2E1YTgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gQ1M6ICAwMDEw
IERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBDUjI6IDAwMDAw
MDAwMDAwMDAxMDIgQ1IzOiAwMDAwMDAwMjAzZGE4MDA0IENSNDogMDAwMDAwMDAwMDM2MDZl
MA0KPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjog
MDAwMDAwMDAwMDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiANCj4gVW5mb3J0dW5hdGVseSBJ
IGRvbid0IGhhdmUgdGltZSB0byBmaW5kIHRoZSByb290IGNhdXNlLiAgV2hhdCBJJ3ZlDQo+
IGZpZ3VyZWQgb3V0IHNvIGZhciBpczoNCj4gDQo+ICAgIGJvb2wgcXVldWVfd29ya19vbihp
bnQgY3B1LCBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3EsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgIHsNCj4gICAgICAgIGJv
b2wgcmV0ID0gZmFsc2U7DQo+ICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiANCj4g
ICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4gDQo+ICAgICAgICBpZiAoIXRlc3Rf
YW5kX3NldF9iaXQoV09SS19TVFJVQ1RfUEVORElOR19CSVQsIHdvcmtfZGF0YV9iaXRzKHdv
cmspKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gVGhlIGFkZHJlc3Mgb2Yg
d29yayBpcyAweDEwMiBzbyB0aGlzIGxpbmUgY2F1c2VzIGEgcGFnZSBmYXVsdCB3aGVuIGl0
DQo+IHRyaWVzIHRvIGFjY2VzcyB0aGUgZGF0YSBmaWVsZCAob2Zmc2V0IDApLg0KPiANCj4g
VGhlIGNhbGxlciBwcm92aWRlZCB0aGUgMHgxMDIgcG9pbnRlciBzbyBsZXQncyBzZWUgd2hl
cmUgaXQgY29tZXMgZnJvbToNCj4gDQo+ICAgIHN0YXRpYyBpbnQgX19pb19xdWV1ZV9zcWUo
c3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHN0cnVjdCBpb19raW9jYiAqcmVxLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzcWVfc3VibWl0ICpzLCBib29sIGZv
cmNlX25vbmJsb2NrKQ0KPiAgICB7DQo+ICAgICAgICAuLi4NCj4gICAgICAgIGlmICghaW9f
YWRkX3RvX3ByZXZfd29yayhsaXN0LCByZXEpKSB7DQo+ICAgICAgICAgICAgaWYgKGxpc3Qp
DQo+ICAgICAgICAgICAgICAgIGF0b21pY19pbmMoJmxpc3QtPmNudCk7DQo+ICAgICAgICAg
ICAgSU5JVF9XT1JLKCZyZXEtPndvcmssIGlvX3NxX3dxX3N1Ym1pdF93b3JrKTsNCj4gICAg
ICAgICAgICBpb19xdWV1ZV9hc3luY193b3JrKGN0eCwgcmVxKTsNCj4gCSAgfn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IGFuZCBxdWV1ZV93b3JrKCkgaXMgY2FsbGVk
IGhlcmU6DQo+IA0KPiAgICBzdGF0aWMgaW5saW5lIHZvaWQgaW9fcXVldWVfYXN5bmNfd29y
ayhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGlvX2tpb2NiICpyZXEpDQo+ICAgIHsNCj4gICAg
ICAgIGludCBydyA9IDA7DQo+IA0KPiAgICAgICAgaWYgKHJlcS0+c3VibWl0LnNxZSkgew0K
PiAgICAgICAgICAgIHN3aXRjaCAocmVxLT5zdWJtaXQuc3FlLT5vcGNvZGUpIHsNCj4gICAg
ICAgICAgICBjYXNlIElPUklOR19PUF9XUklURVY6DQo+ICAgICAgICAgICAgY2FzZSBJT1JJ
TkdfT1BfV1JJVEVfRklYRUQ6DQo+ICAgICAgICAgICAgICAgIHJ3ID0gIShyZXEtPnJ3Lmtp
X2ZsYWdzICYgSU9DQl9ESVJFQ1QpOw0KPiAgICAgICAgICAgICAgICBicmVhazsNCj4gICAg
ICAgICAgICB9DQo+ICAgICAgICB9DQo+IA0KPiAgICAgICAgcXVldWVfd29yayhjdHgtPnNx
b193cVtyd10sICZyZXEtPndvcmspOw0KPiAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBJIG11c3QgYmUgbWlzc2luZyBzb21ldGhpbmcg
dGhvdWdoIGJlY2F1c2UgaXQgc2VlbXMgaW1wb3NzaWJsZSB0byBnZXQNCj4gdGhpcyBmYXIg
aWYgcmVxIGlzIE5VTEwuICBJTklUX1dPUksoKSB3b3VsZCBoYXZlIE9vcHNlZCBhbHJlYWR5
LiAgQWxzbywNCj4gb2Zmc2V0b2Yoc3RydWN0IGlvX2tpb2NiLCB3b3JrKSBpcyAweGEwIGFj
Y29yZGluZyB0byBwYWhvbGUoMSkgc28gd2UNCj4gc3RpbGwgaGF2ZW4ndCByZWFjaGVkIHRo
ZSAweDEwMiBvZmZzZXQgZnJvbSB0aGUgT29wcyByZXBvcnQuDQo+IA0KPiBBbnkgaWRlYXM/
DQoNClRoaXMgaXMgbmV3IGluIDUuNC1yYzE/IEFuZCBob3cgYXJlIHlvdSByZXByb2R1Y2lu
ZyBpdD8gSWYgSSBoYWQgc29tZQ0KaGludHMgaW4gdGhhdCBhcmVhLCBpdCdkIG1ha2UgbGlm
ZSBtdWNoIGVhc2llciBmb3IgbWUuDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
