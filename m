Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0662076EE
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbgFXPMO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 11:12:14 -0400
Received: from verein.lst.de ([213.95.11.211]:44696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404321AbgFXPMO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 11:12:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CAB3568B02; Wed, 24 Jun 2020 17:12:11 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:12:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: move block bits out of fs.h
Message-ID: <20200624151211.GA17344@lst.de>
References: <20200620071644.463185-1-hch@lst.de> <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
> potential for some annoying issues with this, so would rather have it in
> a branch we can modify easily, if we need to.

Hmm, I have a bunch of things building on top of this pending, so that
branch split will be interesting to handle.
