Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E693D09F9
	for <lists+linux-block@lfdr.de>; Wed, 21 Jul 2021 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhGUHGP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jul 2021 03:06:15 -0400
Received: from verein.lst.de ([213.95.11.211]:57725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234706AbhGUHGH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 03:06:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25C3967373; Wed, 21 Jul 2021 09:46:43 +0200 (CEST)
Date:   Wed, 21 Jul 2021 09:46:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: delay freeing the gendisk
Message-ID: <20210721074642.GA12442@lst.de>
References: <20210719093544.431845-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719093544.431845-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Meh, as-is this doesn't even compile.  I had accidentally commited the
fixup in the following patch.  I'll send the whole series in a bit,
but the this particule patch once fixed is probably still a 5.14
candidate.
