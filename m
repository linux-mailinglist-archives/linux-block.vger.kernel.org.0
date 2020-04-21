Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851221B1CD4
	for <lists+linux-block@lfdr.de>; Tue, 21 Apr 2020 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDUD2Z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Apr 2020 23:28:25 -0400
Received: from sonic305-21.consmr.mail.sg3.yahoo.com ([106.10.241.84]:36386
        "EHLO sonic305-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728269AbgDUD2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 23:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587439699; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=btXPIODC0wy4S/iYI97nXCOxDMcVvzNb/95+V4cuz8miSkcPUwpE6d3XdOXeZUIlf6BHnW843uFjORhcMilQ4e6uLNBYGSKWZw85h8HRyHnw2RmQzNVl9hW4rt4LgpDka+WiVGYcPFHwekg/vlu4y6YLTh9OyPxsjm/kFNzj2R3USrjlnSUVMGO9D5JpkKcRwcWdrhCXPW7RL45b2cI4oIx4QMdDXVtuoWrF8dk5Yzp0EccaPlmoqnT1GrQCahWGjlBJTKGTdknoF+w+r2pQ3CblSdMc+wUv/pySvTBqjszW2D3P12jmvNser+kAXKA7SYFcLTyekzejJDVH3nLDpg==
X-YMail-OSG: aQ8qa8cVM1laJUVeLdDfhjSHpzmdx.lZ7orzKsffO7p2Jmii9SNzSNXvywMikSG
 B8.zVCmQFnNijdQj8TON5mdB.mwqIVVAbvWJQarlfmUDThBrXSPISfs4sDqC7NUV2QaWF_MPhobH
 2zKuTM9fW.4tYPGO_mwZt.7znRRFvcWC1p95OHwSYypxxB0jjqML.ZMTmd0uBxjQKoQICtwyyIjQ
 07A.kRyEzx4rOPLgo7KPCMGu4CuPne_ANwNNgOYBXCyVu4M6kM.lTaxi0TlKLavCKHiZS2XFpc9i
 FQhwC47fI0i9w1CXavRBuLmaNu49wPFY_.arHtyxigJIGTvC6Ug6qEg9rCz6CThmENvbUC3pbbIt
 tqGnuaY0CzARt9Qh9bL0yhtzICEihlhpn2pR37389kRKTXF__rROBqd3OZQoE0YmHWYeWWnV3mYv
 7mH8fgtwoXfg32vgKLTLGG52D8iTGhGRBfw3kKcS_Uo9GBX7zOPcqs3enmwQ2LE1tw8PQEGbwKHZ
 NCfmQgHXR0dMd.Mo1OjEchLYe0qT6SI6VF39LPcE4ZDAz4zqsHVK2Tdk7Yw_PDUS5wZVemBWkTAb
 fbrf.p3TXFRQfyLPFieHkhRKFQEORtC7pHZdb1UA_ta3nRIboDDX.6ahdvJVV31IXQGpXCGGQ6V8
 O2LVYPCpPhufZCwl8l.GQMFE8c4k3CsAR4xt5fX0COe0fo3idpC_JTqEzTzGXQo5J_nlNMp2y.wO
 OW6rMbRDs1a2LrBJRX5_uzdf1N6gAKGG_WjKPoaXFCfrURC0o8v81Ba7NJqQv2lVbRFgzafeq6h6
 R0NtMQcRrOplES5iB2GwBB_naH9aq1qpvyPHrdWQT2AIdULRkh3d7njyjpkJKClTJ1INKuFjA0Pw
 wMpr50siU4G1vCRhstMf7aSS_HA7xLv7rfRvpOPy8EbquHCOA1yItzG7NP4_mr1nOp3GJjPnY6Bb
 sBmUG2l12yAAZKTd8c.eDsJg6konu45XGh4WeAbyKnXHsYKm4IawmKPxE.eKwJH1VT4srnhns8H6
 X7EqgEYCkLm3VofnBvlbsgDi4LEHyaQC9bAwMM3TJ7T3ngqIUFN2tof43M5okGWh7_HzOCYp9hKR
 IeWlQPi7QETWzGoolERUoMT6E9G3xmDoStv1Tz6zdqW.unZbQlv2JB6AT2k0Ecb8JLTR3ROAxTWT
 n646Ddc2u4t0ykrUFzTy1CWFf_QaxeHcFx1ryhr.xTueBG.1.xsBMdm8n.HFxbGwCurePmIarxAw
 gWIRfeHK2HuQ8n.P2M24d39idsXwbLRvIHJ0Wh09QpABq2aYmDPBCQH0Qb1TMt4L9a1w51EvTXma
 bvSRvjoAhuOZHY6JeHvDApsu6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Tue, 21 Apr 2020 03:28:19 +0000
Date:   Tue, 21 Apr 2020 03:28:14 +0000 (UTC)
From:   Mr Moussa Dauda <mrmoussadauda@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <1137074648.65813.1587439694480@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1137074648.65813.1587439694480.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15739 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
