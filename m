Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081951C67D2
	for <lists+linux-block@lfdr.de>; Wed,  6 May 2020 08:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgEFGDp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 May 2020 02:03:45 -0400
Received: from verein.lst.de ([213.95.11.211]:39014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgEFGDp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 02:03:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1DC768C65; Wed,  6 May 2020 08:03:41 +0200 (CEST)
Date:   Wed, 6 May 2020 08:03:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] loop: Refactor loop_set_status() size
 calculation
Message-ID: <20200506060341.GA10771@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-5-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
