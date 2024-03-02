Return-Path: <linux-block+bounces-3912-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC186EE3F
	for <lists+linux-block@lfdr.de>; Sat,  2 Mar 2024 03:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BF4B21BF7
	for <lists+linux-block@lfdr.de>; Sat,  2 Mar 2024 02:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93506D39;
	Sat,  2 Mar 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AR7pvpJY"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FE9446
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348391; cv=none; b=YIEJsh1uJKVU85EKJiyV5dJGeNkYdAuzVCHCKnKgShVSOePUhyLT+NBKNWJbdFMkGDQrXjv7HcOMJsoUkx8eKOLCraM9wzMzNL1n9GJiR+T7qy25ZstThNWAFHdn9swuvnDbMWQvBRHMAlQ+0IBKyqQ5PIBS4qS8LXq3RT+Gfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348391; c=relaxed/simple;
	bh=wcNPoo7bbe8Q2KGr6zjYKhQPrtkysYbLY4IjeJ9sPR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swoTWtEln59hk+LXmrrRAjtD4xoQjcHK5TbK+A935eRmyjVbLthxv5ceUsacgwffJjk9/iq7rMJN/6QOsPn/wX/dhlgbJH5rwue7JlbRoIKP/76tRyYcQhPEIvqqXPZiBPofe4wUwBTGJEnxBZ4XmqtZXP/E4/yTbVDQWYxF2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AR7pvpJY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e39226efso2598028e87.0
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 18:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709348387; x=1709953187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z172ARkWy4CrNdjX0Z199syeSzJdWbGHBapXPagpL/g=;
        b=AR7pvpJYzkUU3JrQPSPz3nPlxLVvYY/gK2I4QU76xFmMCyPfRhjUgGPhp4LhF47EAo
         8I+O9H/1N1cEmVCKDAABjIxqS/VxSjyFBGhmZU8enuZrpGag+EobyJ6jOnzdbrwcfwnE
         Z9056MU6pU7lHEK3ty4gHN58nCx3OzsvflNuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709348387; x=1709953187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z172ARkWy4CrNdjX0Z199syeSzJdWbGHBapXPagpL/g=;
        b=aaUqwPBMeRK3lqq9g49msQ6PmSLzv6t7VEI+8fiUrvEeDnqjiYuar7Q0mdkMaP+Qdd
         nKQyLM+1Ttx+CSsZjhql91PjB2WRqDkuWAZHR4zu6g/TL0SLLtOodaonpvQkjWFW/DyH
         878AvTCGGslinnTXi2hHmYBOctl0s5Euvxc2SuzKR0PElWO6+krHSa2a+1g2ppws0Z7m
         ImhhVbjYZ1iP9OP+oqOmfMzaGjA8C4jhBisEuHvk5i6yBgvpUbLLAlT3aARgLuUxtrf7
         YBwTDaPgYIf0+XXtGID4B+KX61ysuwB9zxdSSSeKhLPypaxusXN2j5ltouMqHs6mp8BO
         0iUg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+rFC6QgUFXdrFTTFTvtpsVLzxAe5OXNxmqGM745mYE5P6mx4zCJ0wC5UCI5A8xrcCXLFuFNDfgCVCYlMaBxBsRfZWf/9uuEwYVU=
X-Gm-Message-State: AOJu0YygFsfJAGmSXR6qOOrdy0lKyFyDWE9dZKrJmayfXnbJ7fXl3LVw
	w+S7j69l0TugFy4UxED0+nBFNYQSjWgzD6gETHe8f4LNAY2oodDNnA2sAe75bhbKqfy9YHnI8eq
	MrDrOZQ==
X-Google-Smtp-Source: AGHT+IHn+xdAAXxXpWrmG7p+QTsm90EhmedrYA5BrZdx4sDdYxrEqLjMBouKDy96OpONqzZKLqywyw==
X-Received: by 2002:ac2:499e:0:b0:513:2b1e:22d5 with SMTP id f30-20020ac2499e000000b005132b1e22d5mr2377927lfl.28.1709348387311;
        Fri, 01 Mar 2024 18:59:47 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906048b00b00a4380e85e5csm2237341eja.202.2024.03.01.18.59.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 18:59:46 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44cf608a39so28682066b.0
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 18:59:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXt/UymW0aWzA0neJYl7RKG5P3wwbZx2WnpzfQ4ArF7T41uITMPazKVJHAzv4uSW974TzNU/UG6dpzm9KNsjD4LrNWUXCqVnZdZiJo=
X-Received: by 2002:a17:906:f989:b0:a44:27e8:f514 with SMTP id
 li9-20020a170906f98900b00a4427e8f514mr2273960ejb.38.1709348385722; Fri, 01
 Mar 2024 18:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 18:59:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
Message-ID: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: multipart/mixed; boundary="0000000000005434e50612a4af27"

--0000000000005434e50612a4af27
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 09:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One option might be to make a failed memcpy_from_iter_mc() set another
> flag in the iter, and then make fault_in_iov_iter_readable() test that
> flag and return 'len' if that flag is set.
>
> Something like that (wild handwaving) should get the right error handling.
>
> The simpler alternative is maybe something like the attached.
> COMPLETELY UNTESTED. Maybe I've confused myself with all the different
> indiraction mazes in the iov_iter code.

Actually, I think the right model is to get rid of that horrendous
.copy_mc field entirely.

We only have one single place that uses it - that nasty core dumping
code. And that code is *not* performance critical.

And not only isn't it performance-critical, it already does all the
core dumping one page at a time because it doesn't want to write pages
that were never mapped into user space.

So what we can do is

 (a) make the core dumping code *copy* the page to a good location
with copy_mc_to_kernel() first

 (b) remove this horrendous .copy_mc crap entirely from iov_iter

This is slightly complicated by the fact that copy_mc_to_kernel() may
not even exist, and architectures that don't have it don't want the
silly extra copy. So we need to abstract the "copy to temporary page"
code a bit. But that's probably a good thing anyway in that it forces
us to have nice interfaces.

End result: something like the attached.

AGAIN: THIS IS ENTIRELY UNTESTED.

But hey, so was clearly all the .copy_mc code too that this removes, so...

               Linus

--0000000000005434e50612a4af27
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt9huhmx0>
X-Attachment-Id: f_lt9huhmx0

IGZzL2NvcmVkdW1wLmMgICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLQogaW5jbHVkZS9saW51eC91aW8uaCB8IDE2IC0tLS0tLS0tLS0tLS0tLS0KIGxp
Yi9pb3ZfaXRlci5jICAgICAgfCAyMyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9jb3JlZHVtcC5jIGIvZnMvY29yZWR1bXAuYwppbmRleCBmMjU4YzE3YzE4NDEuLjZhOWI5ZjMy
ODBkOCAxMDA2NDQKLS0tIGEvZnMvY29yZWR1bXAuYworKysgYi9mcy9jb3JlZHVtcC5jCkBAIC04
NzIsNiArODcyLDkgQEAgc3RhdGljIGludCBkdW1wX2VtaXRfcGFnZShzdHJ1Y3QgY29yZWR1bXBf
cGFyYW1zICpjcHJtLCBzdHJ1Y3QgcGFnZSAqcGFnZSkKIAlsb2ZmX3QgcG9zOwogCXNzaXplX3Qg
bjsKIAorCWlmICghcGFnZSkKKwkJcmV0dXJuIDA7CisKIAlpZiAoY3BybS0+dG9fc2tpcCkgewog
CQlpZiAoIV9fZHVtcF9za2lwKGNwcm0sIGNwcm0tPnRvX3NraXApKQogCQkJcmV0dXJuIDA7CkBA
IC04ODQsNyArODg3LDYgQEAgc3RhdGljIGludCBkdW1wX2VtaXRfcGFnZShzdHJ1Y3QgY29yZWR1
bXBfcGFyYW1zICpjcHJtLCBzdHJ1Y3QgcGFnZSAqcGFnZSkKIAlwb3MgPSBmaWxlLT5mX3BvczsK
IAlidmVjX3NldF9wYWdlKCZidmVjLCBwYWdlLCBQQUdFX1NJWkUsIDApOwogCWlvdl9pdGVyX2J2
ZWMoJml0ZXIsIElURVJfU09VUkNFLCAmYnZlYywgMSwgUEFHRV9TSVpFKTsKLQlpb3ZfaXRlcl9z
ZXRfY29weV9tYygmaXRlcik7CiAJbiA9IF9fa2VybmVsX3dyaXRlX2l0ZXIoY3BybS0+ZmlsZSwg
Jml0ZXIsICZwb3MpOwogCWlmIChuICE9IFBBR0VfU0laRSkKIAkJcmV0dXJuIDA7CkBAIC04OTUs
MTAgKzg5Nyw0MCBAQCBzdGF0aWMgaW50IGR1bXBfZW1pdF9wYWdlKHN0cnVjdCBjb3JlZHVtcF9w
YXJhbXMgKmNwcm0sIHN0cnVjdCBwYWdlICpwYWdlKQogCXJldHVybiAxOwogfQogCisvKgorICog
SWYgd2UgbWlnaHQgZ2V0IG1hY2hpbmUgY2hlY2tzIGZyb20ga2VybmVsIGFjY2Vzc2VzIGR1cmlu
ZyB0aGUKKyAqIGNvcmUgZHVtcCwgbGV0J3MgZ2V0IHRob3NlIGVycm9ycyBlYXJseSByYXRoZXIg
dGhhbiBkdXJpbmcgdGhlCisgKiBJTy4gVGhpcyBpcyBub3QgcGVyZm9ybWFuY2UtY3JpdGljYWwg
ZW5vdWdoIHRvIHdhcnJhbnQgaGF2aW5nCisgKiBhbGwgdGhlIG1hY2hpbmUgY2hlY2sgbG9naWMg
aW4gdGhlIGlvdmVjIHBhdGhzLgorICovCisjaWZkZWYgY29weV9tY190b19rZXJuZWwKKworI2Rl
ZmluZSBkdW1wX3BhZ2VfYWxsb2MoKSBhbGxvY19wYWdlKEdGUF9LRVJORUwpCisjZGVmaW5lIGR1
bXBfcGFnZV9mcmVlKHgpIF9fZnJlZV9wYWdlKHgpCitzdGF0aWMgc3RydWN0IHBhZ2UgKmR1bXBf
cGFnZV9jb3B5KHN0cnVjdCBwYWdlICpzcmMsIHN0cnVjdCBwYWdlICpkc3QpCit7CisJdm9pZCAq
YnVmID0ga21hcF9sb2NhbF9wYWdlKHNyYyk7CisJc2l6ZV90IGxlZnQgPSBjb3B5X21jX3RvX2tl
cm5lbChwYWdlX2FkZHJlc3MoZHN0KSwgYnVmLCBQQUdFX1NJWkUpOworCWt1bm1hcF9sb2NhbChi
dWYpOworCXJldHVybiBsZWZ0ID8gTlVMTCA6IGRzdDsKK30KKworI2Vsc2UKKworI2RlZmluZSBk
dW1wX3BhZ2VfYWxsb2MoKSAoKHN0cnVjdCBwYWdlICopOCkgLy8gTm90IE5VTEwKKyNkZWZpbmUg
ZHVtcF9wYWdlX2ZyZWUoeCkgZG8geyB9IHdoaWxlICgwKQorI2RlZmluZSBkdW1wX3BhZ2VfY29w
eShzcmMsZHN0KSAoKGRzdCksKHNyYykpCisKKyNlbmRpZgorCiBpbnQgZHVtcF91c2VyX3Jhbmdl
KHN0cnVjdCBjb3JlZHVtcF9wYXJhbXMgKmNwcm0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCiAJCSAg
ICB1bnNpZ25lZCBsb25nIGxlbikKIHsKIAl1bnNpZ25lZCBsb25nIGFkZHI7CisJc3RydWN0IHBh
Z2UgKmR1bXBfcGFnZSA9IGR1bXBfcGFnZV9hbGxvYygpOworCisJaWYgKCFkdW1wX3BhZ2UpCisJ
CXJldHVybiAwOwogCiAJZm9yIChhZGRyID0gc3RhcnQ7IGFkZHIgPCBzdGFydCArIGxlbjsgYWRk
ciArPSBQQUdFX1NJWkUpIHsKIAkJc3RydWN0IHBhZ2UgKnBhZ2U7CkBAIC05MTIsMTQgKzk0NCwx
NyBAQCBpbnQgZHVtcF91c2VyX3JhbmdlKHN0cnVjdCBjb3JlZHVtcF9wYXJhbXMgKmNwcm0sIHVu
c2lnbmVkIGxvbmcgc3RhcnQsCiAJCSAqLwogCQlwYWdlID0gZ2V0X2R1bXBfcGFnZShhZGRyKTsK
IAkJaWYgKHBhZ2UpIHsKLQkJCWludCBzdG9wID0gIWR1bXBfZW1pdF9wYWdlKGNwcm0sIHBhZ2Up
OworCQkJaW50IHN0b3AgPSAhZHVtcF9lbWl0X3BhZ2UoY3BybSwgZHVtcF9wYWdlX2NvcHkocGFn
ZSwgZHVtcF9wYWdlKSk7CiAJCQlwdXRfcGFnZShwYWdlKTsKLQkJCWlmIChzdG9wKQorCQkJaWYg
KHN0b3ApIHsKKwkJCQlkdW1wX3BhZ2VfZnJlZShkdW1wX3BhZ2UpOwogCQkJCXJldHVybiAwOwor
CQkJfQogCQl9IGVsc2UgewogCQkJZHVtcF9za2lwKGNwcm0sIFBBR0VfU0laRSk7CiAJCX0KIAl9
CisJZHVtcF9wYWdlX2ZyZWUoZHVtcF9wYWdlKTsKIAlyZXR1cm4gMTsKIH0KICNlbmRpZgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC91aW8uaCBiL2luY2x1ZGUvbGludXgvdWlvLmgKaW5kZXgg
YmVhOWM4OTkyMmQ5Li4wMGNlYmUyYjcwZGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdWlv
LmgKKysrIGIvaW5jbHVkZS9saW51eC91aW8uaApAQCAtNDAsNyArNDAsNiBAQCBzdHJ1Y3QgaW92
X2l0ZXJfc3RhdGUgewogCiBzdHJ1Y3QgaW92X2l0ZXIgewogCXU4IGl0ZXJfdHlwZTsKLQlib29s
IGNvcHlfbWM7CiAJYm9vbCBub2ZhdWx0OwogCWJvb2wgZGF0YV9zb3VyY2U7CiAJc2l6ZV90IGlv
dl9vZmZzZXQ7CkBAIC0yNDgsMjIgKzI0Nyw4IEBAIHNpemVfdCBfY29weV9mcm9tX2l0ZXJfZmx1
c2hjYWNoZSh2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSk7CiAK
ICNpZmRlZiBDT05GSUdfQVJDSF9IQVNfQ09QWV9NQwogc2l6ZV90IF9jb3B5X21jX3RvX2l0ZXIo
Y29uc3Qgdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpOwotc3Rh
dGljIGlubGluZSB2b2lkIGlvdl9pdGVyX3NldF9jb3B5X21jKHN0cnVjdCBpb3ZfaXRlciAqaSkK
LXsKLQlpLT5jb3B5X21jID0gdHJ1ZTsKLX0KLQotc3RhdGljIGlubGluZSBib29sIGlvdl9pdGVy
X2lzX2NvcHlfbWMoY29uc3Qgc3RydWN0IGlvdl9pdGVyICppKQotewotCXJldHVybiBpLT5jb3B5
X21jOwotfQogI2Vsc2UKICNkZWZpbmUgX2NvcHlfbWNfdG9faXRlciBfY29weV90b19pdGVyCi1z
dGF0aWMgaW5saW5lIHZvaWQgaW92X2l0ZXJfc2V0X2NvcHlfbWMoc3RydWN0IGlvdl9pdGVyICpp
KSB7IH0KLXN0YXRpYyBpbmxpbmUgYm9vbCBpb3ZfaXRlcl9pc19jb3B5X21jKGNvbnN0IHN0cnVj
dCBpb3ZfaXRlciAqaSkKLXsKLQlyZXR1cm4gZmFsc2U7Ci19CiAjZW5kaWYKIAogc2l6ZV90IGlv
dl9pdGVyX3plcm8oc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKik7CkBAIC0zNTUsNyAr
MzQwLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGlvdl9pdGVyX3VidWYoc3RydWN0IGlvdl9pdGVy
ICppLCB1bnNpZ25lZCBpbnQgZGlyZWN0aW9uLAogCVdBUk5fT04oZGlyZWN0aW9uICYgfihSRUFE
IHwgV1JJVEUpKTsKIAkqaSA9IChzdHJ1Y3QgaW92X2l0ZXIpIHsKIAkJLml0ZXJfdHlwZSA9IElU
RVJfVUJVRiwKLQkJLmNvcHlfbWMgPSBmYWxzZSwKIAkJLmRhdGFfc291cmNlID0gZGlyZWN0aW9u
LAogCQkudWJ1ZiA9IGJ1ZiwKIAkJLmNvdW50ID0gY291bnQsCmRpZmYgLS1naXQgYS9saWIvaW92
X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5jCmluZGV4IGUwYWE2YjQ0MGNhNS4uY2YyZWIyYjJmOTgz
IDEwMDY0NAotLS0gYS9saWIvaW92X2l0ZXIuYworKysgYi9saWIvaW92X2l0ZXIuYwpAQCAtMTY2
LDcgKzE2Niw2IEBAIHZvaWQgaW92X2l0ZXJfaW5pdChzdHJ1Y3QgaW92X2l0ZXIgKmksIHVuc2ln
bmVkIGludCBkaXJlY3Rpb24sCiAJV0FSTl9PTihkaXJlY3Rpb24gJiB+KFJFQUQgfCBXUklURSkp
OwogCSppID0gKHN0cnVjdCBpb3ZfaXRlcikgewogCQkuaXRlcl90eXBlID0gSVRFUl9JT1ZFQywK
LQkJLmNvcHlfbWMgPSBmYWxzZSwKIAkJLm5vZmF1bHQgPSBmYWxzZSwKIAkJLmRhdGFfc291cmNl
ID0gZGlyZWN0aW9uLAogCQkuX19pb3YgPSBpb3YsCkBAIC0yNDQsMjcgKzI0Myw5IEBAIHNpemVf
dCBfY29weV9tY190b19pdGVyKGNvbnN0IHZvaWQgKmFkZHIsIHNpemVfdCBieXRlcywgc3RydWN0
IGlvdl9pdGVyICppKQogRVhQT1JUX1NZTUJPTF9HUEwoX2NvcHlfbWNfdG9faXRlcik7CiAjZW5k
aWYgLyogQ09ORklHX0FSQ0hfSEFTX0NPUFlfTUMgKi8KIAotc3RhdGljIF9fYWx3YXlzX2lubGlu
ZQotc2l6ZV90IG1lbWNweV9mcm9tX2l0ZXJfbWModm9pZCAqaXRlcl9mcm9tLCBzaXplX3QgcHJv
Z3Jlc3MsCi0JCQkgICBzaXplX3QgbGVuLCB2b2lkICp0bywgdm9pZCAqcHJpdjIpCi17Ci0JcmV0
dXJuIGNvcHlfbWNfdG9fa2VybmVsKHRvICsgcHJvZ3Jlc3MsIGl0ZXJfZnJvbSwgbGVuKTsKLX0K
LQotc3RhdGljIHNpemVfdCBfX2NvcHlfZnJvbV9pdGVyX21jKHZvaWQgKmFkZHIsIHNpemVfdCBi
eXRlcywgc3RydWN0IGlvdl9pdGVyICppKQotewotCWlmICh1bmxpa2VseShpLT5jb3VudCA8IGJ5
dGVzKSkKLQkJYnl0ZXMgPSBpLT5jb3VudDsKLQlpZiAodW5saWtlbHkoIWJ5dGVzKSkKLQkJcmV0
dXJuIDA7Ci0JcmV0dXJuIGl0ZXJhdGVfYnZlYyhpLCBieXRlcywgYWRkciwgTlVMTCwgbWVtY3B5
X2Zyb21faXRlcl9tYyk7Ci19Ci0KIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUKIHNpemVfdCBfX2Nv
cHlfZnJvbV9pdGVyKHZvaWQgKmFkZHIsIHNpemVfdCBieXRlcywgc3RydWN0IGlvdl9pdGVyICpp
KQogewotCWlmICh1bmxpa2VseShpb3ZfaXRlcl9pc19jb3B5X21jKGkpKSkKLQkJcmV0dXJuIF9f
Y29weV9mcm9tX2l0ZXJfbWMoYWRkciwgYnl0ZXMsIGkpOwogCXJldHVybiBpdGVyYXRlX2FuZF9h
ZHZhbmNlKGksIGJ5dGVzLCBhZGRyLAogCQkJCSAgIGNvcHlfZnJvbV91c2VyX2l0ZXIsIG1lbWNw
eV9mcm9tX2l0ZXIpOwogfQpAQCAtNjMzLDcgKzYxNCw2IEBAIHZvaWQgaW92X2l0ZXJfa3ZlYyhz
dHJ1Y3QgaW92X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJlY3Rpb24sCiAJV0FSTl9PTihkaXJl
Y3Rpb24gJiB+KFJFQUQgfCBXUklURSkpOwogCSppID0gKHN0cnVjdCBpb3ZfaXRlcil7CiAJCS5p
dGVyX3R5cGUgPSBJVEVSX0tWRUMsCi0JCS5jb3B5X21jID0gZmFsc2UsCiAJCS5kYXRhX3NvdXJj
ZSA9IGRpcmVjdGlvbiwKIAkJLmt2ZWMgPSBrdmVjLAogCQkubnJfc2VncyA9IG5yX3NlZ3MsCkBA
IC02NTAsNyArNjMwLDYgQEAgdm9pZCBpb3ZfaXRlcl9idmVjKHN0cnVjdCBpb3ZfaXRlciAqaSwg
dW5zaWduZWQgaW50IGRpcmVjdGlvbiwKIAlXQVJOX09OKGRpcmVjdGlvbiAmIH4oUkVBRCB8IFdS
SVRFKSk7CiAJKmkgPSAoc3RydWN0IGlvdl9pdGVyKXsKIAkJLml0ZXJfdHlwZSA9IElURVJfQlZF
QywKLQkJLmNvcHlfbWMgPSBmYWxzZSwKIAkJLmRhdGFfc291cmNlID0gZGlyZWN0aW9uLAogCQku
YnZlYyA9IGJ2ZWMsCiAJCS5ucl9zZWdzID0gbnJfc2VncywKQEAgLTY3OSw3ICs2NTgsNiBAQCB2
b2lkIGlvdl9pdGVyX3hhcnJheShzdHJ1Y3QgaW92X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJl
Y3Rpb24sCiAJQlVHX09OKGRpcmVjdGlvbiAmIH4xKTsKIAkqaSA9IChzdHJ1Y3QgaW92X2l0ZXIp
IHsKIAkJLml0ZXJfdHlwZSA9IElURVJfWEFSUkFZLAotCQkuY29weV9tYyA9IGZhbHNlLAogCQku
ZGF0YV9zb3VyY2UgPSBkaXJlY3Rpb24sCiAJCS54YXJyYXkgPSB4YXJyYXksCiAJCS54YXJyYXlf
c3RhcnQgPSBzdGFydCwKQEAgLTcwMyw3ICs2ODEsNiBAQCB2b2lkIGlvdl9pdGVyX2Rpc2NhcmQo
c3RydWN0IGlvdl9pdGVyICppLCB1bnNpZ25lZCBpbnQgZGlyZWN0aW9uLCBzaXplX3QgY291bnQp
CiAJQlVHX09OKGRpcmVjdGlvbiAhPSBSRUFEKTsKIAkqaSA9IChzdHJ1Y3QgaW92X2l0ZXIpewog
CQkuaXRlcl90eXBlID0gSVRFUl9ESVNDQVJELAotCQkuY29weV9tYyA9IGZhbHNlLAogCQkuZGF0
YV9zb3VyY2UgPSBmYWxzZSwKIAkJLmNvdW50ID0gY291bnQsCiAJCS5pb3Zfb2Zmc2V0ID0gMAo=
--0000000000005434e50612a4af27--

