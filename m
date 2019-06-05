Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB74C35A3F
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2019 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfFEKJ4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Jun 2019 06:09:56 -0400
Received: from verein.lst.de ([213.95.11.211]:41928 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfFEKJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 06:09:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 69D4368B20; Wed,  5 Jun 2019 12:09:29 +0200 (CEST)
Date:   Wed, 5 Jun 2019 12:09:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: too large sg segments with commit 09324d32d2a08
Message-ID: <20190605100928.GA9828@lst.de>
References: <alpine.LFD.2.21.1906051057200.2118@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906051057200.2118@schleppi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem is that we don't communicate the block level max_segment
size to the iommu, and the commit really is just the messenger.

I'll cook up a series to fix this as papering over it in every driver
does not seem sustainable.
