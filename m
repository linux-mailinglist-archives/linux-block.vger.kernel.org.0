Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE85226058
	for <lists+linux-block@lfdr.de>; Mon, 20 Jul 2020 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGTNCd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jul 2020 09:02:33 -0400
Received: from verein.lst.de ([213.95.11.211]:46817 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgGTNCd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:02:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CCC868BFE; Mon, 20 Jul 2020 15:02:29 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:02:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] scsi: core: run queue in case of IO queueing failure
Message-ID: <20200720130228.GA402@lst.de>
References: <20200720025435.812030-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720025435.812030-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
