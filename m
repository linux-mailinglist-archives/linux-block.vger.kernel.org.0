Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA18271335
	for <lists+linux-block@lfdr.de>; Sun, 20 Sep 2020 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITJmg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Sep 2020 05:42:36 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:38302 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgITJmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 05:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600594955; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=VHqVD6MvqR7OaKVNESt+1AHyc7hjVFuboPm0TI925sFydsmAoqJwI+SotT08QhJqm8efPEF9Zo1ZILE3h/QDpietd1JwaRv5HiKr54+T1ol1m2A7KZwSed/aebn81eQBZ6LL+Cf2IjS/QI/wLWlJlny8X+TwvEq/abTYWNoPMHsOIbwHC5ga9hW/BTsV/8PtUqNRLPrQDla5oMeu5XNBhR9vHiYGCVTJ1c2y/+OCnoz+bvENCUbY0LiF/do0zBlXNY04BsbhgQUNclhMk1rDwJz82XD9NaHmy5d+iXXuAKG0m6VZPxjxM7vOUO+2uC0ufykH1WDHsX8izntm0+nujA==
X-YMail-OSG: zrS4W54VM1m4_AlQly0yLqfVN13zJf1791GSXlIAaD0qsEatUJ1tmiD46nkHqc9
 iZGBD.3T91k4IL1g9ZPPFL8uyaqz.bg5ow2Uy9DjlaI5rSCSSFKSFNeX3MTZxaX4YOD5CnXYrtLt
 VZKtQBWlqsnoLM6G.d6oICwKY_5OeZBe1dIQE2Uq4CRFcDXdxxNvYHtyrVTonYQMj8yUt_RmCRlz
 fNCSqKkCK7F79mljf.hLraPS_Fu8WdbtSuyvXUNZ9uaYKoBnVOXg3ENQcKiz1xcLZsR0bYuretBU
 nfF6qclumRsPoJdr7BtrGkpnOBm_Qmtas3XHBl007VtezKlZkR31LUVw9pE7H_aTQvXHaqzISJ3h
 QQI2moZFtXM3e_X.aBvd1YVbdq4wPVQmVO4mCxxf31Y5j8xSA5Bv9TeZ_4Uuej3QzZHDwPNh6UVd
 RumhAR7A4ckR_3ua2j4c3l32sLGyhMu0USd2A.85ipaI2DRWS.Se5jxtAbYPyLgBxdOyE9OQaalv
 qUKeGCjiugTsCFXYObXFXW0NfIYBXKU0wPMhLIfGBIraq49IqtnS3WeuYiV0SVWKQ0A0OiTaYxRP
 UVqudevQza7D2_9u4XJm2YEJDXI5jcMsSFvRuzB5QfRLEYnz7GMBCRPhAIEbRAadAelBuMBBUsPG
 iT8Aozz.XbxP.yuthIL8d.Z20eSDyUKFInsFPIfzCkUWmgLPABOlAwyefsve_kG_Pwtlu2v36Lkk
 HGgcFfmDhKFbb.25IidjOrSDh7YBj67Coy9ycY7iNnIOkvzhpzTjYON3bxICe8OM2UnmJNcZgDMF
 24rFAqVRCq_fl6X01NqW.7zjFHiOpV5R7nL_hfsniLo4yYrkrW1uDv9ZcqiDrYVs9Te2vjs.LHXR
 touoJznwWouScq192GGfVb9YfCUP_JJoUIhiDR6Yn_hnFMSxDxPczPFCk83cpS_e08MDzX.P1xFS
 Wj71_nr4zSqFzGG6cgF9DFdLAUrI5l1Fw8f6eoXZStry5JApGtIfDWOcQ_AcApmFhsiRvqnWOGtF
 cBW7yPFU3p_2hfWN6Lj2yNmE0tfughZXZPCNpDKKl6AQwVBCWa8sZfw403ick9j5k81W2Is4v28t
 AC2VATJk8_jT47aKtKT5AJkpVzraO9WTIvYfbKAKHTdxar6TaZWr60Ofhi0hFcX1ItuNevrs.6ym
 1I_OJoaeIV8H2P4JDOPLmO6TzwdTaP9g__CHF0Vvm.V8j5kqcRePhSRUNfgY6bUBdzr11RBRGv3H
 gP9wAIYKnzipTF29BOj1roOV13BGfXN.RSjqccokoeD9Cf_.I6tO_OkRacI0_bHLc8JH0m55F4.4
 s6dLJyr8JDQRsUyoQEN121xS2nR_vqo.0Hg9Xa6sJFrhqxFAxQcez30zKX2iNbdCimAfA9z8mpEU
 0c3kGkGv5YCI4jinK1P3tI0xpRRvQLlgvWwmBcAfERctP8p2FhbDEJ1g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sun, 20 Sep 2020 09:42:35 +0000
Date:   Sun, 20 Sep 2020 09:42:32 +0000 (UTC)
From:   "Mrs. Mina A, Brunel" <mrs.minaaaliyahbrunel216@gmail.com>
Reply-To: mrs.minaaaliyahbrunel31@gmail.com
Message-ID: <1841677556.4034201.1600594952623@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1841677556.4034201.1600594952623.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
