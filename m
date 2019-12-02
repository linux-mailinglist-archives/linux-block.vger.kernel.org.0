Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094A810EF3C
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2019 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfLBSXq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Dec 2019 13:23:46 -0500
Received: from verein.lst.de ([213.95.11.211]:39661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfLBSXp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 13:23:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE8A468BE1; Mon,  2 Dec 2019 19:23:43 +0100 (CET)
Date:   Mon, 2 Dec 2019 19:23:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: don't send uevent for empty disk when not
 invalidating
Message-ID: <20191202182343.GB9639@lst.de>
References: <20191202182134.4004-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202182134.4004-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
