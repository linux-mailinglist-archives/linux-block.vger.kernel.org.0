Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1958B8A4
	for <lists+linux-block@lfdr.de>; Sun,  7 Aug 2022 01:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiHFXDA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 6 Aug 2022 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiHFXDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 19:03:00 -0400
X-Greylist: delayed 4520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 16:02:39 PDT
Received: from blackstone.apzort.in (unknown [202.142.85.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD5D101E7
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=anurav.com;
        s=default; h=Content-Type:MIME-Version:Message-ID:Reply-To:From:Date:Subject:
        To:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ldpBOAytp4kuV8PRIAhH5R2E6wB48ejxBw7yah2pPgw=; b=YeuwzwYK33LBDDKR6dt08P5ujq
        P9tIP8f1hGk4ch3oZahVBhH/oOw227IfyH8lL6fTkq/rifgRLtqJ+g45R1S1/FTSzkukxeQZYsdgR
        umwVlF0KRGkGqshG1hK0RefHhXHBxctuUK4+TuULEIVPGGo/FBAwxDPwuO2e6O8GZTBBTjr905wAc
        JZQD3TFdMc5GHeFj2M9tvyQp5Nw+MR7WMtTWEdeB0T3xrMLb6PDE/Dunb2DkltX1KcQXAV01Tc5vu
        emOm6pCLqh8CW9BVAChT3rtEgpRtIMsvYFUkRy3KxBkLCklCcFp/IRxWFmEadN7YJF30ARosNTWxl
        L9S/ORLA==;
Received: from apzort by blackstone.apzort.in with local (Exim 4.94.2)
        (envelope-from <apzort@blackstone.apzort.in>)
        id 1oKRdN-005lAC-IN
        for linux-block@vger.kernel.org; Sun, 07 Aug 2022 03:17:01 +0530
To:     linux-block@vger.kernel.org
Subject: =?us-ascii?Q?Anurav_Dhwaj__"THE_WORLD_FINANCIAL_CRISIS_CAN_M?=  =?us-ascii?Q?AKE_YOU_RICH!"?=
X-PHP-Script: www.anurav.com/index.php for 156.146.63.156
X-PHP-Originating-Script: 1000:PHPMailer.php
Date:   Sat, 6 Aug 2022 21:47:01 +0000
From:   Anurav Dhwaj <mail@anurav.com>
Reply-To: mail@anurav.com
Message-ID: <JYrxB6JjGcHOAjpz502ZrdtTkXxToPMfIYkYIBIXA@www.anurav.com>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blackstone.apzort.in
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1000 989] / [47 12]
X-AntiAbuse: Sender Address Domain - blackstone.apzort.in
X-Get-Message-Sender-Via: blackstone.apzort.in: authenticated_id: apzort/from_h
X-Authenticated-Sender: blackstone.apzort.in: mail@anurav.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PHP_SCRIPT,
        RCVD_IN_PBL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [202.142.85.54 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.4 PHP_SCRIPT Sent by PHP script
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Message Body:
A QUICK AND EFFECTIVE WAY TO GET RICH https://telegra.ph/Cryptocurrency-makes-people-millionaires-at-15-people-per-hour---Page-892071-08-03

-- 
This e-mail was sent from a contact form on Anurav Dhwaj  (https://www.anurav.com)

