Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93198519051
	for <lists+linux-block@lfdr.de>; Tue,  3 May 2022 23:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiECVlV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 May 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbiECVlU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 17:41:20 -0400
X-Greylist: delayed 529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 14:37:47 PDT
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A941630
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1651613337; bh=YqOzyzus4HS2GBGYEa94oUY19jW0uP5i6hhpOqHgnoo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HnKzQywzYjy7gdJsMOZVJRGNxpUOEvk8ra5DYc/bfh2asKkDcofRgK4CtNCz4XXvb
         elE6rl3hvp3iI40LZTxC3FcftGb783XdGVnrape1y/DtuN8qSWqBuHjnTx5KCuJFEg
         nnu8YnN5XhAwgEmfFpkOu8ZXSR1yuFDE6fkBSRvzqqTcYe2c1RTBq/dICX8pgi4VT5
         Iw/fcgu9Cn5BUWlCHBXcEoduBMMX2iO/tG4xME34xBEhIPuMaErVEi1IgQ8ZNM4pDF
         o9ux+T0iiGcs125O47WBeeltAyzbWxaN0+Id1lJwpyl8ki0ph9xEBZPaafKixaYKFW
         iZwBkkeGkbJxw==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 0396032072E;
        Tue,  3 May 2022 21:28:56 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     hch@lst.de
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp
Subject: Re: [PATCH v2] block: deprecate autoloading based on dev_t
Date:   Tue,  3 May 2022 15:28:48 -0600
Message-Id: <20220503212848.5853-1-dmoulding@me.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220104071647.164918-1-hch@lst.de>
References: <20220104071647.164918-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oiLtxzS3BniKvvOkUurx3cOzS96H9JFP
X-Proofpoint-ORIG-GUID: oiLtxzS3BniKvvOkUurx3cOzS96H9JFP
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=559 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I believe this change may break some mdraid setups. It looks to me
like mdadm still depends on this legacy autoload behavior. There are
some situations where mdadm does mknod to create a temporary device
node and then attempts to open that temporary node. On my system,
after disabling legacy autoloading, mdadm fails (ENODEV) when it
attempts the open of the temporary node (block 9:127).

It seems this is an issue when mdadm attempts to assemble an array
that it sees as "foreign". And it makes the determination of whether
an array is foreign or not based on whether the hostname recorded in
the array superblock(s) matches the current system's hostname. It's my
observation that some init systems do not set the system hostname
early enough, so arrays that should look local will be treated as
foreign arrays by mdadm, which makes it go down this path where it
will depend on the legacy autoloading behavior.

As an aside, this happens even though udev is in use. mdadm ships with
udev rules that cause mdadm to be invoked to assemble arrays when
uevents fire that announce the appearance of "file systems" of type
linux_raid_member. So while udev is supposed to supplant this legacy
autoloading behavior, it appears there are at least some current
real-world cases where udev itself ultimately ends up itself depending
(in an indirect way) on this legacy behavior :)

Cheers,

-- Dan
