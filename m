Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429EF2002D7
	for <lists+linux-block@lfdr.de>; Fri, 19 Jun 2020 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbgFSHmL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Jun 2020 03:42:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHmL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:42:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77F68B196;
        Fri, 19 Jun 2020 07:42:08 +0000 (UTC)
Date:   Fri, 19 Jun 2020 09:42:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200619074207.vamnsauvdhac2n43@beryllium.lan>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618145354.1139350-4-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 07:53:52AM -0700, Keith Busch wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Implements support for the I/O Command Sets command set. The command set
> introduces a method to enumerate multiple command sets per namespace. If
> the command set is exposed, this method for enumeration will be used
> instead of the traditional method that uses the CC.CSS register command
> set register for command set identification.
> 
> For namespaces where the Command Set Identifier is not supported or
> recognized, the specific namespace will not be created.
> 
> Reviewed-by: Javier González <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
