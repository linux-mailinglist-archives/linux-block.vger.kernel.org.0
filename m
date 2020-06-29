Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649E020E15E
	for <lists+linux-block@lfdr.de>; Mon, 29 Jun 2020 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgF2UzD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Jun 2020 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgF2Uy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 16:54:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA3C061755;
        Mon, 29 Jun 2020 13:54:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq0nj-002KpE-MJ; Mon, 29 Jun 2020 20:54:51 +0000
Date:   Mon, 29 Jun 2020 21:54:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop: fix passing zero to 'PTR_ERR' warning
Message-ID: <20200629205451.GC2786714@ZenIV.linux.org.uk>
References: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 04:48:42PM +0800, Ding Xiang wrote:
> Fix a static code checker warning:
>     drivers/block/loop.c:798 loop_attr_backing_file_show()
>     warn: passing zero to 'PTR_ERR'

Better fix the root cause of that the problem - bullshit checker,
that is...
