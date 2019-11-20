Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D410371F
	for <lists+linux-block@lfdr.de>; Wed, 20 Nov 2019 10:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfKTJ6l (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Nov 2019 04:58:41 -0500
Received: from sonic311-23.consmr.mail.ne1.yahoo.com ([66.163.188.204]:44128
        "EHLO sonic311-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727671AbfKTJ6l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 04:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574243918; bh=+JEosOT2sVu+hkruxS8M8QchlzaUMN4I7aAE0kLIJgE=; h=Date:From:Reply-To:Subject:From:Subject; b=C5tL3bpRHuqLW1HV9psxSvTpMBFzCiw/tGE8PpIb7NJ4HBxTXamrVADpmTejlRWJImW53a2DV7DujMD0GqIkxhI4EvqrkiRPAkhQc3KBUTcGti/fMYhQ4Imdg+V5qknsNaBTyj85GO732lG7+tYWZTD/bxFg+kK9ajZvQwn+zWqLCoA15qLGHO8R6HTlv64d6GK4nZKDy5585yXcgxDDblN/I5vW64NXIE20LSV0k9VR4QFyiORanTmgm46O60TfI9b0zGVKMifNrB+EP3ycQM3UfxxxT14X+/HsAKtO1CIOtUbYmu4o7NHpvKkrWCAoIHHCUQIzS45+6Xb5omuWMQ==
X-YMail-OSG: 8RA5.GQVM1mDyeKtYGNpMuDP3OOmh92DUC6ayGK0P7M71GM.CUdKKEy3mxWK9.h
 7BuZ52XhYqo_txwj_zO12Ou9hqsIn9scgrYs.5pJa2w4n4ZqTwH5FdE3twQkQNIhMbgBi.CyVMzK
 deFlPDRg3qeiuAAucorh.rWvetOTbGrSp7l.jtbqdGp73_tx3Fdpf0mibLZuLAbXOebQcIp2FOr7
 JCPMomgRZG5pga9C1x3HA59t5baJzjAwzqiO6cM0JJ.s9pY_WAajNLKLCnsUipSYaNiE18IGPkAX
 cbgZjwoFpWd1pMVqkJYlLf8Bu6fTHiFW03w1xf_so0MIIw_jhg85in9Hg_7M7ec1Zs2othjDyoXs
 pu5t8pkjPHD3vPXIeqzhAmJuCcoywkwJv3gt1LKp2qyIXleXt2R3YHNpZ8AcEQlbxMbwPV9rrq7b
 8NIOdiUDaBCbKwwgrf2YpVW8sPktesms5Xc6URsLj..bqN66y2XpxAP61CZZnbh4eeKsMGb_VH_g
 8UyClOjdmivimV6YZCoeEzvRfZ88rWWz3h3TrsvBwAY273USVfKxiV.OB6mkcbvIhdG9.5S1eYYx
 Cgmj47ce5ffUtHjJvk9m94z_4NCQZi8gLdRdWrqiUuoCAKRLYAwCyFDFF46Jt7AG7BtRKyWRfWIc
 GI2ZG71KFvZMA.49pPCdyjuRS4ne3VouAWVspmn38BqD6S.ON.RFktBJ6M0DSysyDHzTfIkUOo7O
 XPA6lEaKxR1nYld5CUyOjRR8TF7ol7cCVTOeiuFF4UwoOocxqhuOUTyTuif5q9W0RdoHEF3leJ4F
 cT4MamONbkxniVvRpdws9zEX7HSlXJ6iI6TbB1I6fe0CFmJ6YbOt6GLQYGJDlifSrX9ECpJaZEgi
 sIZ6wAYl8dkbTwFcUGNI5ctSDOPT.LJfQGMsP4eGRhBIKQ_cp9okha8xNtld7uP8MOx79KF6Wxp1
 TelSWAwsdDxki0v7PauF92Mna9NgJNTM22QuQYZQNCOEE.zGElcoAXj969tz02E7bKjbSBW7x8hl
 Biytn.amCeFg4hp4THkFpVxD4SIPlLY_uIYzhHKKDzwVCiu.sqMWT36wpcwtTzd1UIEft9JP9oGv
 sJCNZ_yo4mAtHEoupYD.0fxXfVydwpwoDvnuiatPvFfdqEbwXsQrqVluMkWqmslwfQ9DOD6xiL39
 ZCM5mfzeLyhEzKMtTlkpKguKhKK0t5UfwcBYN2UNBEoMDye2Nax4xMPfXCtk1VlXxbi06.vAvWxZ
 w7..2ur1NVFYEGHBu7KLcIsq2m14MkIZnUGnUCxTUvaCH4._Bze.gNTzU6rBsTD7zOgqTHex8Ww-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Nov 2019 09:58:38 +0000
Date:   Wed, 20 Nov 2019 09:58:34 +0000 (UTC)
From:   "Mustafa Sani," <sanimustafa87@gmail.com>
Reply-To: mustafasani281@gmail.com
Message-ID: <737013925.2814914.1574243914906@mail.yahoo.com>
Subject: My good friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



My good friend,

I just want to know if you, can help me, to transfer the amount of ($6Million). After the transfer we have to share it, 50% for me, and 50% for you. Please let me know if you can help me for more information regarding the transfer. I hope you can work with me honestly?

Thanks.

 Mustafa Sani,
