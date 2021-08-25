Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEB3F71B3
	for <lists+linux-block@lfdr.de>; Wed, 25 Aug 2021 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhHYJ2T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Aug 2021 05:28:19 -0400
Received: from verein.lst.de ([213.95.11.211]:55442 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236399AbhHYJ2T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 05:28:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85C3B67357; Wed, 25 Aug 2021 11:27:31 +0200 (CEST)
Date:   Wed, 25 Aug 2021 11:27:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+2c98885bcd769f56b6d6@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in nbd_genl_connect (2)
Message-ID: <20210825092731.GA1328@lst.de>
References: <0000000000007900bd05ca5cf80b@google.com> <20210825085525.2147-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825085525.2147-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 25, 2021 at 04:55:25PM +0800, Hillf Danton wrote:
> Because no nbd is kfreed without being removed from the nbd idr, finding
> a freed nbd in the idr with nbd_index_mutex held means the nbd is not a
> valid pointer, and fix the uaf by cutting the chance for invalid nbd.
> 
> Only for thoughts now.

That is a bug, but not really the problem here.  I think the issue
is the completion issue that Tetsuo reported.  Looking into that at
the moment.
