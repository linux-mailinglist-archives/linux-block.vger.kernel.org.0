Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF0B51B9
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2019 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfIQPmN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 11:42:13 -0400
Received: from sonic309-13.consmr.mail.bf2.yahoo.com ([74.6.129.123]:36887
        "EHLO sonic309-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729760AbfIQPmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 11:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568734931; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:From:Subject; b=VGNY0U3giuxgy+w/uWgwSdVV8NAr3IHMqCK6hSQzKYqCcPOrjvwKkeyHOdbUliCC26mcf5B0o8zjOghXC2X87rYVWPdz+VQZQFvyXrjqiYdRjd+YcJ5g5b8x/hPgmV323f+iU+U0Y8PP9ocWwL0t/1Lb9EkHLaWUn+kMOLfOOLh74+mb5QgY4pMcVAtXrkPfMxT+9E96x58FAYo3VzIgI41CsEhHle3QEP4cHT6vFHFZfIggcYOS+dU5S8IBq03RmD+2KxDFXrR21tCr+APP72sEDrs5sZwn3O/r/Kpqv/l2Kj0EuoJ3eklwgT3EzrfsNz3t45pA3toCHs9xMEdI8g==
X-YMail-OSG: DNUdW4kVM1kdd.8apoFGEYGMhAPKjnjasA.gDeLzb4D9zBdNbzdlGy7TGN_x.x6
 lQW1NEa2_XOFaRau0wgck6lT_OZfnJYMywrnwSZABJIqtWwbhHoDVijrgxY6OmsvoZUx.9PCibmE
 c0QHwNoZvmzxuiVuwf72.Lra9H.RMfsTmQrn_4XOGWB17971LZR73lS1CIm3bBezQzK1op7MGO8A
 mXmA1X9_50rHyn2KfdrPiQrnWH98vHE0lUHKr7g7068clB5kOlEFBG7Vq13uaMytC5EJVxsYf28N
 mqLY3yRQpJ.vaUHkoT1DK60bdwNERpP5YPxYdVRErTK63S8PSL9X3c4ei1PX_zcygRj47ukMaUKW
 iKQaKYmUEAEbFakKVcIo6B3Kg1qyVMkQe9aMAMFihhpo8CO3nt_I3tQeLfwntkRugLaNwvRUW1LN
 a0iUdWCkKYrx.g3CKx_1ymLi9tww7diXwEq15aTq72Ll9PQfzYqKn.iWysIMvUNVoiala.sl.v1M
 k7xDOCznjMImF0UXf5qJFx2BVrLVbtIE28Qn7Up5ZYfziZ7JWyzs9V3GTvwzI8CRCZwxX6.Dg0IQ
 JT6xhdUBpiVPnH_PeS8nuTzOgukreMC4u4jMBv2NxB5YqA0pCddxUf_cBJ2laP_GhkZgZB6eM51y
 6fZXwG.3B27Bi643.qJiNEAixja4.APPpquf8dCFLDHQ.8IWSgS6ZT3mzXH28yjkBvWR0Ge5WFEn
 FPmtCfpZhekpbgBwCRCvGXkMZIDwMDh5hCYFU8UgCnLS2Uyu8_A9FAP4oKeuLzp8n1AZqpu4P_An
 UIpfDMHoUCsJoZgVP40DezJzgzE6j27zGcrUMu1sVZxYi1.gpwn4TbN5jIxZqkRtTiLmAQ2lyWHR
 Ug0XjrYfL1EtP3Cs2jYwzznyNDR88_jCBAIrsF9.an4jRkVAMjFFyXyzFKjNr.NT5JASoZ8qpwjt
 Iw6JKkkj6uWhwlNFSUPs8uGBQykypNPvsSDEuUhaNnEw6Q9elPrj1mzLcfxq_adS.3SqfZiDjcu9
 BAtebMo7IJGu1TAyhzo_8B1ZNWSvz_4CGKrLB9DqLSpt2.mFpwyl_iWvnUbEPRDaDuXiJjeVeKTh
 o1KhoK.wP2.qC.UaESJ.9sjxt14.NPdFwNSaJQkbX62TBcHkcvZIwObX6YugmisjIyfOb56kC4JE
 bp1AA5RBd3RlUlBbOu7T3JKONRZu8plrTe1UBq.xtHjfOeGbazKyX7oAlN91QuIvrcgtVvsGHRZg
 4EPjbCbU8KY_k0htsYfhnPTlN6hufEPXCP.Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Sep 2019 15:42:11 +0000
Date:   Tue, 17 Sep 2019 15:42:09 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1008059605.5821128.1568734929747@mail.yahoo.com>
Subject: CONFIDENTIAL FROM MS LISA HUGH(BUSINESS)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

There is this fund that was keep in my custody years ago,please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.


Ms Lisa Hugh
