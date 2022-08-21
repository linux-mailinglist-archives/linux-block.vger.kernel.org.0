Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934859B229
	for <lists+linux-block@lfdr.de>; Sun, 21 Aug 2022 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiHUFsb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 21 Aug 2022 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiHUFsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Aug 2022 01:48:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E0EE21
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 22:48:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A952E68C4E; Sun, 21 Aug 2022 07:48:26 +0200 (CEST)
Date:   Sun, 21 Aug 2022 07:48:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests v3 2/6] nbd/rc: load nbd module explicitly
Message-ID: <20220821054826.GA25878@lst.de>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com> <20220819093920.84992-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819093920.84992-3-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 19, 2022 at 06:39:16PM +0900, Shin'ichiro Kawasaki wrote:
> After the commit "common/rc: avoid module load in _have_driver()",
> _have_driver() no longer loads specified module. However, nbd test cases
> and _have_nbd_netlink() function assume that the module is loaded by
> calling _have_driver(). This causes test case failures and unexpected
> skips. To fix them, load and unload modules explicitly in functions
> _start_nbd_server*(), _stop_nbd_server*() and _have_nbd_netlink().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
