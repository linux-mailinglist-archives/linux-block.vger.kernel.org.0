Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736B4D96A0
	for <lists+linux-block@lfdr.de>; Tue, 15 Mar 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbiCOIqk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Mar 2022 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbiCOIqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:46:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231A4D9EB
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:45:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC40268AA6; Tue, 15 Mar 2022 09:44:58 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:44:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Message-ID: <20220315084458.GA3911@lst.de>
References: <00000000000099c4ca05da07e42f@google.com> <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp> <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp> <20220314152318.k4cvwe737q5r5juw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314152318.k4cvwe737q5r5juw@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 04:23:18PM +0100, Jan Kara wrote:
> Honestly, the anon inode trick makes the code pretty much unreadable. As
> far as I remember Christoph was not pricipially against using task_work. He
> just wanted the task_work API to be improved so that it is easier to use.

This whole patch is awful.  And no, I don't think task_work_add really has
any business here.  We need to properly unwind the mess instead of piling
things higher and higher.
