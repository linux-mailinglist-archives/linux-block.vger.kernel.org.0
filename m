Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016F6F5BA3
	for <lists+linux-block@lfdr.de>; Wed,  3 May 2023 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjECP5u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 May 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjECP5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:57:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BF4EEB;
        Wed,  3 May 2023 08:57:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44F2368AA6; Wed,  3 May 2023 17:57:45 +0200 (CEST)
Date:   Wed, 3 May 2023 17:57:45 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <20230503155745.GD31700@lst.de>
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4> <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p6> <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 07:10:48PM +0900, Jinyoung CHOI wrote:
> When a request is initialized through the bio, bio's integrity
> information is not reflected in the request.

Uuh.  This looks like a pretty grave bug unless I'm missing something.
Can you:

 - submit this as a fix for 6.3 and -stable?
 - maybe find what broke this and add a fixes tag?
