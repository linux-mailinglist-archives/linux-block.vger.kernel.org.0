Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F193F60C7
	for <lists+linux-block@lfdr.de>; Tue, 24 Aug 2021 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhHXOoN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Aug 2021 10:44:13 -0400
Received: from verein.lst.de ([213.95.11.211]:51932 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237891AbhHXOoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:44:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84BAD6736F; Tue, 24 Aug 2021 16:43:22 +0200 (CEST)
Date:   Tue, 24 Aug 2021 16:43:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>, linux-block@vger.kernel.org,
        Yi Zhang <yizhan@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: WARNING: CPU: 0 PID: 11219 at block/genhd.c:594
 del_gendisk+0x1f8/0x218
Message-ID: <20210824144322.GA28505@lst.de>
References: <CA+QYu4oZN2Z-z1uRjPQO6UL4d5CuRM6NCsSAPG0+BKb5K2o23A@mail.gmail.com> <bb197903-2f01-5a64-9856-2767d3aba103@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb197903-2f01-5a64-9856-2767d3aba103@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just sent a fix. 
