Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22F082C4D
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2019 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbfHFHGv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Aug 2019 03:06:51 -0400
Received: from verein.lst.de ([213.95.11.211]:53901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbfHFHGv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 03:06:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D297668B02; Tue,  6 Aug 2019 09:06:48 +0200 (CEST)
Date:   Tue, 6 Aug 2019 09:06:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] lightnvm: pblk: use kvmalloc for metadata
Message-ID: <20190806070648.GC15546@lst.de>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com> <1564566096-28756-4-git-send-email-hans@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564566096-28756-4-git-send-email-hans@owltronix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 11:41:35AM +0200, Hans Holmberg wrote:
> There is no reason now not to use kvmalloc, so
> so replace the internal metadata allocation scheme.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
