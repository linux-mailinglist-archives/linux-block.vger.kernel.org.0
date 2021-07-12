Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE03C467C
	for <lists+linux-block@lfdr.de>; Mon, 12 Jul 2021 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhGLG01 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Jul 2021 02:26:27 -0400
Received: from verein.lst.de ([213.95.11.211]:51197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234485AbhGLGZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 02:25:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01B1268AFE; Mon, 12 Jul 2021 08:22:41 +0200 (CEST)
Date:   Mon, 12 Jul 2021 08:22:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+0fe7752e52337864d29b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, hare@suse.de, hch@lst.de, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in del_gendisk
Message-ID: <20210712062241.GA9697@lst.de>
References: <0000000000003fdaa905c6db08d0@google.com> <20210712041417.835-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712041417.835-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 12, 2021 at 12:14:17PM +0800, Hillf Danton wrote:
> Fix it by s/nbd->destroy_complete/&nbd->destroy_complete/
> 
> Note this isnt a cure to what the syzbot reported.

Yeah.  The completion stuff does look bogus, but the actual sysbot
report is about the fact that del_gendisk is called from ->release.
