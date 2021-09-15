Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395C240C68B
	for <lists+linux-block@lfdr.de>; Wed, 15 Sep 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhIONlx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Sep 2021 09:41:53 -0400
Received: from verein.lst.de ([213.95.11.211]:36400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhIONlx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 09:41:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F9F167357; Wed, 15 Sep 2021 15:40:33 +0200 (CEST)
Date:   Wed, 15 Sep 2021 15:40:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] scsi: core: cleanup request queue before releasing
 gendisk
Message-ID: <20210915134032.GB13933@lst.de>
References: <20210915092547.990285-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092547.990285-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Btw, do you have a good reproducer for issues in this area?
