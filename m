Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77424501E2
	for <lists+linux-block@lfdr.de>; Mon, 15 Nov 2021 10:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhKOKBG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Nov 2021 05:01:06 -0500
Received: from verein.lst.de ([213.95.11.211]:39123 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhKOKBG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 05:01:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CFCA68AA6; Mon, 15 Nov 2021 10:58:09 +0100 (CET)
Date:   Mon, 15 Nov 2021 10:58:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Message-ID: <20211115095808.GA32005@lst.de>
References: <00000000000089436205d07229eb@google.com> <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp> <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com> <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp> <20211112062015.GA28294@lst.de> <7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
