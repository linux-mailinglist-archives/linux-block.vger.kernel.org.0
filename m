Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8449C2F7
	for <lists+linux-block@lfdr.de>; Wed, 26 Jan 2022 06:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiAZFPl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jan 2022 00:15:41 -0500
Received: from verein.lst.de ([213.95.11.211]:38424 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbiAZFPl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:15:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF33167373; Wed, 26 Jan 2022 06:15:37 +0100 (CET)
Date:   Wed, 26 Jan 2022 06:15:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH V3] block: loop:use kstatfs.f_bsize of backing file to
 set discard granularity
Message-ID: <20220126051537.GA20737@lst.de>
References: <20220126035830.296465-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126035830.296465-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
